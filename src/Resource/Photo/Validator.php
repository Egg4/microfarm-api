<?php

namespace App\Resource\Photo;

use Egg\Exception\InvalidContent as InvalidContentException;

class Validator extends \Egg\Validator\Generic
{
    protected function validateUrl($value)
    {
        if(strlen($value) == 0){
            throw new InvalidContentException(sprintf('Url is empty'));
        }
    }
}