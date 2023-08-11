{include file="common/subheader.tpl" title=__("Avatar")}

<div class="control-group">
    <label class="control-label">{__("select_photo")}:</label>
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
