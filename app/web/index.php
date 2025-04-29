<?php

use yii\web\Application;

require __DIR__ . '/../vendor/autoload.php';
require __DIR__ . '/../vendor/yiisoft/yii2/Yii.php';

$config = [
    'id' => 'minimal-app',
    'basePath' => dirname(__DIR__),
    'components' => [
        'request' => [
            'cookieValidationKey' => 'some-random-string',
        ],
    ],
    'defaultRoute' => 'site/index',
];

(new Application($config))->run();
