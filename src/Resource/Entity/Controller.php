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
        $entityId = $authentication['user_role']['entity_id'];
        $userId = $authentication['user']['id'];
        $userRoleRepository = $this->container['repository']['user_role'];

        if (in_array($resource, ['entity'])) {
            $userRoles = $userRoleRepository->selectAll(['user_id' => $userId]);
            return [
                'id' => $userRoles->toArray('entity_id'),
            ];
        }

        if (in_array($resource, ['user'])) {
            $userRoles = $userRoleRepository->selectAll(['entity_id' => $entityId]);
            return [
                'id' => $userRoles->toArray('user_id'),
            ];
        }

        if (in_array($resource, ['user_role'])) {
            return [
                'user_id' => $userId,
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