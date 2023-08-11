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

use Tygh\Registry;

if (!defined('BOOTSTRAP')) { die('Access denied'); }

function fn_profile_photo_check_uploaded_data_pre($uploaded_data, &$filter_by_ext, &$result, &$processed) {

    $setting = Registry::get('addons.profile_photo');

    $size_limit = $setting['file_size_limit'];

    if($uploaded_data['size'] > $size_limit) {

        fn_set_notification('E', __('error'), __('text_not_allowed_to_upload_file_size', array(
            '[size]' => $setting['file_size_limit']
        )));

        $result = false;
        $processed = true;
    } else {
        $filter_by_ext = my_fn_get_allowed_extensions($setting);
    }
}

function my_fn_get_allowed_extensions($setting_array) {

    $new_array = array();
    foreach($setting_array as $key => $value) {

        $exploded_key = explode('_', $key);
        $setting_type = "$exploded_key[1]_$exploded_key[2]";
        $setting_ext = $exploded_key[0];

        if($setting_type == 'ext_check' && $value == 'Y') {
            $new_array[] = $setting_ext;
        }
    }
    return $new_array;
}