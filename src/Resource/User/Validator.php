<?php

namespace App\Resource\User;

use Egg\Exception\InvalidContent as InvalidContentException;

class Validator extends \Egg\Validator\Generic
{
    public function signup(array $params)
    {
        $this->checkRequired($params);
        $this->checkParams($params);
        $this->checkForeignKeys($params);
        $this->checkUniqueKeys($params);
    }

    public function activate(array $params)
    {
        $this->requireParams(['key'], $params);

        $data = $this->container['cache']->get($params['key']);
        if (!$data) {
            throw new \Egg\Http\Exception($this->container['response'], 404, new \Egg\Http\Error(array(
                'name'          => 'not_found',
                'description'   => sprintf('Key "%s" not found', $params['key']),
            )));
        }
    }

    public function login(array $params)
    {
        $this->requireParams(['email', 'password'], $params);
        $this->checkParams($params);

        $entity = $this->container['repository'][$this->resource]->selectOneByEmail($params['email']);
        $verifyPassword = $this->container['password']['verify'];
        if (!$entity OR !$verifyPassword($params['password'], $entity->password)) {
            throw new \Egg\Http\Exception($this->container['response'], 403, new \Egg\Http\Error(array(
                'name'          => 'authentication_failure',
                'description'   => 'Authentication failed',
            )));
        }
    }

    public function logout(array $params)
    {

    }

    protected function validateEmail($value)
    {
        if (!filter_var($value, FILTER_VALIDATE_EMAIL)) {
            throw new InvalidContentException(sprintf('Email "%s" is invalid', $value));
        }
    }

    protected function validatePassword($value)
    {
        if(!preg_match('/[A-Z]/', $value)){
            throw new InvalidContentException(sprintf('Password must have at least 1 uppercase'));
        }
        if(!preg_match('/[a-z]/', $value)){
            throw new InvalidContentException(sprintf('Password must have at least 1 lowercase'));
        }
        if(!preg_match('/[0-9]/', $value)){
            throw new InvalidContentException(sprintf('Password must have at least 1 digit'));
        }
        if(strlen($value) < 8){
            throw new InvalidContentException(sprintf('Password must have at least 8 characters'));
        }
        if(strlen($value) > 64){
            throw new InvalidContentException(sprintf('Password must have at the most 64 characters'));
        }
    }
}