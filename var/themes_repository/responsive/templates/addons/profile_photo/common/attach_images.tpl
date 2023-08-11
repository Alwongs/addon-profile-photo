{*
image_key - required
image_name - required
image_object_type - required

image_object_id - optional
image_type - optional
*}

{if !"SMARTY_ATTACH_IMAGES_LOADED"|defined}
{assign var="tmp" value="SMARTY_ATTACH_IMAGES_LOADED"|define:true}
<script>
(function(_, $) {
    $.ceEvent('on', 'ce.delete_image', function(r, p) {
        if (r.deleted == true) {
            $('#' + p.result_ids).closest('a').replaceWith('<div class="no-image"><span class="cs-icon glyph-image" title="' + _.tr('no_image') + '"></span></div>');
            $('a[data-ca-target-id=' + p.result_ids + ']').hide();
        }
    });

    $.ceEvent('on', 'ce.delete_image_pair', function(r, p) {
        if (r.deleted == true) {
            $('#' + p.result_ids).remove();
        }
    });
}(Tygh, Tygh.$));
</script>
{/if}

{if !$original_image}
    {assign var="thumbnail_width" value="85"}
{/if}
{assign var="_plug" value="."|explode:""}
{assign var="key" value=$image_key|default:"0"}
{assign var="object_id" value=$image_object_id|default:"0"}
{assign var="name" value=$image_name|default:""}
{assign var="object_type" value=$image_object_type|default:""}
{assign var="type" value=$image_type|default:"M"}
{assign var="pair" value=$image_pair|default:$_plug}
{assign var="suffix" value=$image_suffix|default:""} {* FIXME: unused, not being set anywhere *}

<input type="hidden" name="{$name}_image_data{$suffix}[{$key}][pair_id]" value="{$pair.pair_id}" class="cm-image-field" />
<input type="hidden" name="{$name}_image_data{$suffix}[{$key}][type]" value="{$type|default:"M"}" class="cm-image-field" />
<input type="hidden" name="{$name}_image_data{$suffix}[{$key}][object_id]" value="{$object_id}" class="cm-image-field" />

<div id="box_attach_images_{$name}_{$key}" class="attach-images">


    {hook name="attach_images:thumbnail"}
    {/hook}

    {if !$no_detailed}
    {hook name="attach_images:detailed"}
    {if $detailed_title}
        <h5><span>{$detailed_title}</span></h5>
    {/if}
    
    <div class="upload-box clearfix">
        <div class="pull-left image-wrap">
            {if !$hide_images}
                {if $pair.detailed_id}
                    {if !("MULTIVENDOR"|fn_allowed_for && $runtime.company_id && $object_type == "category")}
                        <a data-ca-target-id="image_{$pair.detailed_id}" href="{"image.delete_image?pair_id=`$pair.pair_id`&image_id=`$pair.detailed_id`&object_type=detailed"|fn_url}" class="image-delete cm-confirm cm-post cm-tooltip cm-ajax delete cm-delete-image-link" data-ca-event="ce.delete_image" title="{__("remove")}">{include_ext file="addons/profile_photo/common/icon.tpl" class="icon-remove-sign" icon_text=""}</a>
                    {/if}
                {/if}
                <div class="image">
                    {if $pair.detailed_id}
                        {include file="addons/profile_photo/common/image.tpl" image=$pair.detailed image_id=$pair.detailed_id image_width=85}
                    {else}
                        <div class="no-image">{include_ext file="addons/profile_photo/common/icon.tpl" class="glyph-image" title=__("no_image") icon_text=""}</div>
                    {/if}
                </div>
            {/if}
        </div>

        <div class="image-upload cm-hide-with-inputs">
            {include file="addons/profile_photo/common/fileuploader.tpl" var_name="`$name`_image_detailed`$suffix`[`$key`]" is_image=true}
            {hook name="attach_images:options_for_detailed"}
            {/hook}
        </div>

    </div>
    {/hook}
    {/if}
</div>
