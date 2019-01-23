<?php

namespace App\Resource\Entity;

use Egg\Exception\InvalidContent as InvalidContentException;

class Validator extends \Egg\Validator\Generic
{
    public function all(array $params)
    {
        $this->requireParams(['resources'], $params);

        if (!is_array($params['resources'])) {
            throw new InvalidContentException(sprintf('Param "resources" array expected'));
        }

        $schema = $this->container['schema']->getData();
        foreach($params['resources'] as $resource) {
            if (!isset($schema->tables[$resource])) {
                throw new InvalidContentException(sprintf('Resource "%s" not found', $resource));
            }
        }
    }
}