<?php

// /src/AppBundle/Controller/RestLoginController.php

namespace AppBundle\Controller;

use FOS\RestBundle\Controller\Annotations;
use FOS\RestBundle\Controller\FOSRestController;
use FOS\RestBundle\Routing\ClassResourceInterface;
use FOS\RestBundle\Controller\Annotations\RouteResource;
use Nelmio\ApiDocBundle\Annotation\ApiDoc;

/**
 *
 * @RouteResource("login", pluralize=false)
 */
class RestLoginController extends FOSRestController implements ClassResourceInterface
{
    /**
     * @ApiDoc(
     *     section="Authentification",
     *  description="login",
     *  requirements={
     *      {
     *          "name"="username",
     *          "dataType"="string",
     *          "requirement"="*",
     *          "description"="nom de l'utilisaeur"
     *      },
     *     {
     *          "name"="password",
     *          "dataType"="password",
     *          "requirement"="*",
     *          "description"="password de l'utilisaeur"
     *      }
     *  },
     *
     *     statusCodes = {
     *        200 = "User can Login with good credentials (username, email)",
     *        401 = "User cannot Login with bad credentials",
     *        405 = "Cannot GET Login"
     *    }
     * )
     *
     */
    public function postAction()
    {
        // route handled by Lexik JWT Authentication Bundle
        throw new \DomainException('You should never see this');
    }
}