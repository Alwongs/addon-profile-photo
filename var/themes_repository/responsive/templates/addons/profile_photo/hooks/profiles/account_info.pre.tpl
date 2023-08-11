{if $user_data}
    {assign var="id" value=$user_data.user_id}
{else}
    {assign var="id" value=0}
{/if}

{include file="addons/profile_photo/common/subheader.tpl" title=__("Avatar")}

<div class="control-group">
    <div class="controls">
        {include file="addons/profile_photo/common/attach_images.tpl"

            image_name="user_main" 
            image_object_type="user"
            image_pair=$main_pair 
            image_object_id=$id 
            no_thumbnail=true
        }
    </div>
</div>

