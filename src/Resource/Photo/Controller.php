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
        $params['url'] = $this->createFile($binary, $params);

        return parent::create($params);
    }

    public function update($id, array $params)
    {
        $binary = $this->decodeUrl($params);
        if ($binary !== false) {
            $this->deleteFile($id);
            $params['url'] = $this->createFile($binary, $params);
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
        return $this->container['config']['photo']['dir'] . $url;
    }

    protected function createFile($binary, array $params)
    {
        $authentication = $this->container['request']->getAttribute('authentication');

        $replacements = [
            '{entity_id}' => $authentication['entity_id'],
            '{task_id}' => $params['task_id'],
            '{photo_hash}' => \Egg\Yolk\Rand::alphanum(32),
        ];
        $url = str_replace(
            array_keys($replacements),
            array_values($replacements),
            $this->container['config']['photo']['url']
        );

        $filename = $this->urlToFilename($url);
        $dirname = dirname($filename);
        if (!file_exists($dirname)) {
            mkdir($dirname, 0777, true);
        }
        file_put_contents($filename, $binary);

        return $url;
    }

    protected function deleteFile($id)
    {
        $photo = $this->repository->selectOneById($id);
        $filename = $this->urlToFilename($photo->url);
        @unlink($filename);

        // Remove 2 levels directories
        $dirname = dirname($filename);
        if (file_exists($dirname) AND $this->isDirEmpty($dirname)) {
            rmdir($dirname);
        }
        $dirname = dirname($dirname);
        if (file_exists($dirname) AND $this->isDirEmpty($dirname)) {
            rmdir($dirname);
        }
    }

    protected function isDirEmpty($dirname)
    {
        $iterator = new \FilesystemIterator($dirname);
        return !$iterator->valid();
    }
}