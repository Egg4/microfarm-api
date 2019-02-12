<?php

namespace App\Resource\Photo;

use Egg\Exception\InvalidContent as InvalidContentException;

class Controller extends \Egg\Controller\Generic
{
    public function create(array $params)
    {
        $binary = $this->decodeUrl($params);
        if ($binary === false) {
            throw new InvalidContentException(sprintf('Url decode error'));
        }
        $params['url'] = $this->createFile($binary);

        return parent::create($params);
    }

    public function update($id, array $params)
    {
        $binary = $this->decodeUrl($params);
        if ($binary !== false) {
            $this->deleteFile($id);
            $params['url'] = $this->createFile($binary);
        }

        return parent::update($id, $params);
    }

    public function delete($id)
    {
        $this->deleteFile($id);

        return parent::delete($id);
    }

    protected function decodeUrl(array $params)
    {
        if (!isset($params['url'])) {
            return false;
        }
        $base64 = preg_replace('#^data:image/\w+;base64,#i', '', $params['url']);
        $base64 = str_replace(' ', '+', $base64);

        return base64_decode($base64, true);
    }

    protected function urlToFilename($url)
    {
        return realpath($this->container['config']['photo']['dir'] . $url);
    }

    protected function createFile($content)
    {
        $url = str_replace(
            '{id}',
            \Egg\Yolk\Rand::alphanum(8),
            $this->container['config']['photo']['url']
        );

        $filename = $this->urlToFilename($url);
        file_put_contents($filename, $content);

        return $url;
    }

    protected function deleteFile($entityId)
    {
        $entity = $this->repository->selectOneById($entityId);
        $filename = $this->urlToFilename($entity->url);
        @unlink($filename);
    }
}