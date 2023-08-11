<?php
/***************************************************************************
*                                                                          *
*   (c) 2004 Vladimir V. Kalynyak, Alexey V. Vinokurov, Ilya M. Shalnev    *
*                                                                          *
* This  is  commercial  software,  only  users  who have purchased a valid *
* license  and  accept  to the terms of the  License Agreement can install *
* and use this program.                                                    *
*                                                                          *
****************************************************************************
* PLEASE READ THE FULL TEXT  OF THE SOFTWARE  LICENSE   AGREEMENT  IN  THE *
* "copyright.txt" FILE PROVIDED WITH THIS DISTRIBUTION PACKAGE.            *
****************************************************************************/

use Tygh\Tygh;
use Tygh\Registry;

defined('BOOTSTRAP') or die('Access denied');

if ($mode == 'update' || $mode == 'add') {


    $main_pair = fn_get_image_pairs($_REQUEST['user_id'], 'user', 'M', DESCR_SL);

    Tygh::$app['view']->assign('main_pair', $main_pair);
}
