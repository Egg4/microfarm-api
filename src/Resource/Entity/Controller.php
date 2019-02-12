<?php

namespace App\Resource\Entity;

class Controller extends \Egg\Controller\Generic
{
    public function all(array $params)
    {
        $result = [];
        foreach($params['resources'] as $resource) {
            $filterParams = $this->getFilterParams($resource);
            $repository = $this->container['repository'][$resource];
            $models = $repository->selectAll($filterParams);
            $serializer = $this->container['serializer'][$resource];
            $result[$resource] = $serializer->serialize($models);
        }

        return $result;
    }

    private function getFilterParams($resource)
    {
        $authentication = $this->container['request']->getAttribute('authentication');
        $entityId = $authentication['entity_id'];
        $userRoleRepository = $this->container['repository']['user_role'];

        if (in_array($resource, ['entity'])) {
            return [
                'id' => $entityId,
            ];
        }

        if (in_array($resource, ['user'])) {
            $userRoles = $userRoleRepository->selectAll(['entity_id' => $entityId]);
            return [
                'id' => $userRoles->toArray('user_id'),
            ];
        }

        if (in_array($resource, ['category', 'family', 'genus', 'species', 'plant'])) {
            return [];
        }

        return [
            'entity_id' => $entityId,
        ];
    }
}