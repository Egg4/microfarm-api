<?php

namespace App\Resource\User;

class Controller extends \Egg\Controller\Generic
{
    public function login(array $params)
    {
        $entity = $this->repository->selectOneByEmail($params['email']);
        $serializer = $this->container['serializer'][$this->resource];
        $data[$this->resource] = $serializer->serialize($entity);
        $authentication = $this->container['authenticator']->create($data);

        return $authentication;
    }

    public function logout()
    {
        $authentication = $this->container['request']->getAttribute('authentication');
        $this->container['authenticator']->delete($authentication['key']);
    }
}