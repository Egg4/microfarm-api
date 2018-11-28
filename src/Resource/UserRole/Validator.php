<?php

namespace App\Resource\UserRole;

class Validator extends \Egg\Validator\Generic
{
    public function authenticate(array $params)
    {
        $this->requireParams(['id'], $params);
        $this->checkParams($params);
        $this->checkEntityExists($this->resource, ['id' => $params['id']]);
    }
}