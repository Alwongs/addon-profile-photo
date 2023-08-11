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

if (!defined('BOOTSTRAP')) { die('Access denied'); }



if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    //
    // Delete image
    //
    if ($mode == 'delete_image') {



        if (AREA == 'C' && !empty($auth['user_id'])) {

            // fn_print_die(444);

            fn_delete_image($_REQUEST['image_id'], $_REQUEST['pair_id'], $_REQUEST['object_type']);



            if (defined('AJAX_REQUEST')) {

                Tygh::$app['ajax']->assign('deleted', true);

            } elseif (!empty($_SERVER['HTTP_REFERER'])) {

                return array(CONTROLLER_STATUS_REDIRECT, $_SERVER['HTTP_REFERER']);
            }
            exit;

        }


    }
}
