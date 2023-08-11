{$post_max_size = $server_env->getIniVar("post_max_size")}
{$upload_max_filesize = $server_env->getIniVar("upload_max_filesize")}

{if $max_upload_filesize}
    {if $post_max_size > $max_upload_filesize}
        {$post_max_size = $max_upload_filesize}
    {/if}
    {if $upload_max_filesize > $max_upload_filesize}
        {$upload_max_filesize = $max_upload_filesize}
    {/if}
{/if}

<script>
(function(_, $) {
    $.extend(_, {
        post_max_size_bytes: '{$post_max_size|fn_return_bytes}',
        files_upload_max_size_bytes: '{$upload_max_filesize|fn_return_bytes}',

        post_max_size_mbytes: '{$post_max_size}',
        files_upload_max_size_mbytes: '{$upload_max_filesize}',
        allowed_file_path: '{fn_get_http_files_dir_path()}'
    });

    _.tr({
        file_is_too_large: '{__("file_is_too_large")|escape:"javascript"}',
        files_are_too_large: '{__("files_are_too_large")|escape:"javascript"}'
    });
}(Tygh, Tygh.$));
</script>

{script src="js/tygh/fileuploader_scripts.js"}
{script src="js/tygh/node_cloning.js"}

{assign var="id_var_name" value="`$prefix`{$var_name|md5}"}

<div class="fileuploader cm-fileuploader cm-field-container" {if $disabled_param}hidden disabled{/if}>
<input type="hidden" id="{$label_id}" value="{if $images}{$id_var_name}{/if}" />

{hook name="fileuploader:uploader"}
<div id="file_uploader_{$id_var_name}">
    <div class="upload-file-section" id="message_{$id_var_name}" title="">
        <p class="cm-fu-file hidden">{include_ext file="addons/profile_photo/common/icon.tpl"
            class="icon-remove-sign cm-tooltip hand"
            id="clean_selection_`$id_var_name`"
            title=__("remove_this_item")
            data=[
                "onclick" => "Tygh.fileuploader.clean_selection(this.id); {if $multiupload !== 'Y'}Tygh.fileuploader.toggle_links(this.id, 'show');{/if} Tygh.fileuploader.check_required_field('{$id_var_name}', '{$label_id}');"
            ]
            icon_text=""
        }&nbsp;<span class="upload-filename"></span></p>
        {if $multiupload !== "Y"}<p class="cm-fu-no-file {if $images}hidden{/if}">{__("text_select_file")}</p>{/if}
    </div>

    {strip}
        <input type="hidden" {""}
               name="file_{$var_name}" {""}
               value="{if $image_name}{$image_name}{/if}" {""}
               id="file_{$id_var_name}" {""}
               class="cm-fileuploader-field {if $is_image}cm-image-field{/if}"
               {if $disabled_param}{""} disabled{/if}
               {if $target_form}{""} form="{$target_form}"{/if}
        />
        <input type="hidden" {""}
               name="type_{$var_name}" {""}
               value="{if $image_name}local{/if}" {""}
               id="type_{$id_var_name}" {""}
               class="cm-fileuploader-field {if $is_image}cm-image-field{/if}"
               {if $disabled_param}{""} disabled{/if}
               {if $target_form}{""} form="{$target_form}"{/if}
        />

    <div class="btn-group {if $multiupload != "Y" && $images}hidden{/if}" id="link_container_{$id_var_name}">
        <div class="upload-file-local">
            <a class="btn"><span data-ca-multi="Y" {if !$images}class="hidden"{/if}>{$upload_another_file_text|default:__("upload_another_file")}</span><span data-ca-multi="N" {if $images}class="hidden"{/if}>{$upload_file_text|default:__("local")}</span></a>
            <div class="image-selector">
                <label for="local_{$id_var_name}">
                    <input type="file" name="file_{$var_name}" id="local_{$id_var_name}" onchange="Tygh.fileuploader.show_loader(this.id); {if $multiupload == "Y"}Tygh.fileuploader.check_image(this.id);{/if} Tygh.fileuploader.check_required_field('{$id_var_name}', '{$label_id}');" class="file{if $is_image} cm-image-field{/if}" data-ca-empty-file="" onclick="Tygh.$(this).removeAttr('data-ca-empty-file');">
                </label>
            </div>
        </div>
        
        <a class="btn" onclick="Tygh.fileuploader.show_loader(this.id);" id="url_{$id_var_name}">{__("url")}</a>
        {if $hidden_name}
            <input type="hidden" {""}
                   name="{$hidden_name}" {""}
                   id="hidden_input_{$id_var_name}" {""}
                   value="{$hidden_value}"
                   {if $target_form}{""} form="{$target_form}"{/if}
            />
        {/if}
    </div>

    {if $allowed_ext}
        <p class="mute micro-note">
            {__("text_allowed_to_upload_file_extension", ["[ext]" => $allowed_ext]) nofilter}
        </p>
    {/if}

    {/strip}
</div>
{/hook}

</div><!--fileuploader-->
