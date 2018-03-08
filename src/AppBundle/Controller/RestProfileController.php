<?php

// /src/AppBundle/Controller/RestProfileController.php

namespace AppBundle\Controller;

use AppBundle\Entity\User;
use FOS\RestBundle\View\View;
use FOS\RestBundle\Controller\Annotations;
use FOS\RestBundle\Controller\Annotations\Get;
use FOS\RestBundle\Controller\FOSRestController;
use FOS\RestBundle\Routing\ClassResourceInterface;
use FOS\RestBundle\Controller\Annotations\RouteResource;
use FOS\UserBundle\Event\FilterUserResponseEvent;
use FOS\UserBundle\Event\GetResponseUserEvent;
use FOS\UserBundle\FOSUserEvents;
use FOS\UserBundle\Event\FormEvent;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpKernel\Exception\AccessDeniedHttpException;
use Symfony\Component\HttpKernel\Exception\MethodNotAllowedHttpException;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\ParamConverter;
use Symfony\Component\Security\Core\User\UserInterface;
use Nelmio\ApiDocBundle\Annotation\ApiDoc;
/**
 * @RouteResource("profile", pluralize=false)
 *
 */
class RestProfileController extends FOSRestController implements ClassResourceInterface
{
    /**
     *  @ApiDoc(
     *     section="profile",
     *  description="Affiche le profile du utilisateur",
     *  requirements={
     *      {
     *          "name"="user",
     *          "dataType"="integer",
     *          "requirement"="\d+",
     *          "description"="l'id du utilisateur"
     *      }
     *  },
     *
     *  output={ "class"=User::class, "collection"=true},
     *     statusCodes = {
     *        401 = "Invalid JWT Token",
     *        200 = "Can view own profile",
     *        403 = "Cannot view another user's profile"
     *    }
     * )
     *
     * @Get("/profile/{user}")
     *
     * @ParamConverter("user", class="AppBundle:User")
     *
     */
    public function getAction(UserInterface $user)
    {
        if ($user !== $this->getUser()) {
            throw new AccessDeniedHttpException();
        }

        return $user;
    }



    /**
     * @ApiDoc(
     *     section="profile",
     *  description="modifier totalement le profile du utilisateur",
     *  requirements={
     *     {
     *          "name"="user",
     *          "dataType"="integer",
     *          "requirement"="\d+",
     *          "description"="l'id du utilisateur"
     *      },
     *      {
     *          "name"="username",
     *          "dataType"="string",
     *          "requirement"="*",
     *          "description"="username du utilisateur"
     *      },
     *     {
     *          "name"="email",
     *          "dataType"="email",
     *          "requirement"="*",
     *          "description"="email du utilisateur"
     *      },
     *     {
     *          "name"="current_password",
     *          "dataType"="string",
     *          "requirement"="*",
     *          "description"="password du utilisateur"
     *      }
     *  },
     *     statusCodes = {
     *        204 = "Can replace their own profile",
     *        400 = "Must supply current password when updating profile information",
     *        403 = "Cannot replace another user's profile"
     *    }
     * )
     *
     * @param Request       $request
     * @param UserInterface $user
     *
     * @ParamConverter("user", class="AppBundle:User")
     *
     * @return View|\Symfony\Component\Form\FormInterface
     */
    public function putAction(Request $request, UserInterface $user)
    {
        return $this->updateProfile($request, true, $user);
    }

    /**
     * @ApiDoc(
     *     section="profile",
     *  description="modifier le profile du utilisateur",
     *  requirements={
     *     {
     *          "name"="user",
     *          "dataType"="integer",
     *          "requirement"="\d+",
     *          "description"="l'id du utilisateur"
     *      },
     *     {
     *          "name"="username",
     *          "dataType"="string",
     *          "requirement"="*",
     *          "description"="username du utilisateur"
     *      },
     *     {
     *          "name"="email",
     *          "dataType"="email",
     *          "requirement"="*",
     *          "description"="email du utilisateur"
     *      },
     *     {
     *          "name"="current_password",
     *          "dataType"="string",
     *          "requirement"="*",
     *          "description"="password du utilisateur"
     *      }
     *  },
     *     statusCodes = {
     *        204 = "Can update their own profile",
     *        400 = "Must supply current password when updating profile information",
     *        403 = "Cannot update another user's profile"
     *    }
     * )
     *
     * @param Request       $request
     * @param UserInterface $user
     *
     * @ParamConverter("user", class="AppBundle:User")
     *
     * @return View|\Symfony\Component\Form\FormInterface
     */
    public function patchAction(Request $request, UserInterface $user)
    {
        return $this->updateProfile($request, false, $user);
    }

    /**
     * @param Request       $request
     * @param bool          $clearMissing
     * @param UserInterface $user
     */
    public function updateProfile(Request $request, $clearMissing = true, UserInterface $user)
    {
        $user = $this->getAction($user);

        /** @var $dispatcher \Symfony\Component\EventDispatcher\EventDispatcherInterface */
        $dispatcher = $this->get('event_dispatcher');

        $event = new GetResponseUserEvent($user, $request);
        $dispatcher->dispatch(FOSUserEvents::PROFILE_EDIT_INITIALIZE, $event);

        if (null !== $event->getResponse()) {
            return $event->getResponse();
        }

        /** @var $formFactory \FOS\UserBundle\Form\Factory\FactoryInterface */
        $formFactory = $this->get('fos_user.profile.form.factory');

        $form = $formFactory->createForm(['csrf_protection' => false]);
        $form->setData($user);

        $form->submit($request->request->all(), $clearMissing);

        if (!$form->isValid()) {
            return $form;
        }

        /** @var $userManager \FOS\UserBundle\Model\UserManagerInterface */
        $userManager = $this->get('fos_user.user_manager');

        $event = new FormEvent($form, $request);
        $dispatcher->dispatch(FOSUserEvents::PROFILE_EDIT_SUCCESS, $event);

        $userManager->updateUser($user);

        // there was no override
        if (null === $response = $event->getResponse()) {
            return $this->routeRedirectView(
                'get_profile',
                ['user' => $user->getId()],
                Response::HTTP_NO_CONTENT
            );
        }

        // unsure if this is now needed / will work the same
        $dispatcher->dispatch(FOSUserEvents::PROFILE_EDIT_COMPLETED, new FilterUserResponseEvent($user, $request, $response));

        return $this->routeRedirectView(
            'get_profile',
            ['user' => $user->getId()],
            Response::HTTP_NO_CONTENT
        );
    }
}