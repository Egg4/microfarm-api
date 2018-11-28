<?php

namespace App\Resource\UserRole;

class Controller extends \Egg\Controller\Generic
{
    public function authenticate(array $params)
    {
        $entity = $this->repository->selectOneById($params['id']);
        $authentication = $this->container['request']->getAttribute('authentication');
        $serializer = $this->container['serializer'][$this->resource];
        $authentication[$this->resource] = $serializer->serialize($entity);
        $this->container['authenticator']->set($authentication['key'], $authentication);

        return $authentication;
    }
}