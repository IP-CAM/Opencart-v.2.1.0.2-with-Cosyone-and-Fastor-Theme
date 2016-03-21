<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-setting" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?=$t_settings;?> <?=$title;?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-setting" class="form-horizontal">
          <ul class="nav nav-tabs">
              
            <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $t_general_tab; ?></a></li>
            <li><a href="#tab-overlay" data-toggle="tab"><?php echo $t_overlay_tab; ?></a></li>
            <li><a href="#tab-window" data-toggle="tab"><?php echo $t_window_tab; ?></a></li>
            <li><a href="#tab-fields" data-toggle="tab"><?php echo $t_fields_tab; ?></a></li>
            <li><a href="#tab-extra" data-toggle="tab"><?php echo $t_extra_tab; ?></a></li>
              
          </ul>
            
          <div class="tab-content">
              
            <div class="tab-pane active" id="tab-general">
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-return"><span data-toggle="tooltip" title="<?php echo $t_module_status_help; ?>"><?php echo $t_module_status; ?></span></label>
                  <div class="col-sm-10">
                    <div class="switch-toggle switch-candy">
                        <input id="off" name="pdqo_module[settings][general][module_status]" value="0" type="radio" <?php if($settings_general_module_status == 0) echo 'checked'; ?>>
                        <label for="off" onclick=""><?=$t_off;?></label>

                        <input id="on" name="pdqo_module[settings][general][module_status]" value="1" type="radio" <?php if($settings_general_module_status == 1) echo 'checked'; ?>>
                        <label for="on" onclick=""><?=$t_on;?></label>
                        <a></a>
                    </div>
                  </div>
                </div>
            </div>
            
            <div class="tab-pane" id="tab-window">
                
                <div class="form-group">
                  <label class="col-sm-2 control-label"><?php echo $t_window_width; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="pdqo_module[settings][window][width]" class="form-control" id="pdqo-settings-window-width" value="<?=$settings_window_width;?>" />
                  </div>
                </div>
                <fieldset>
                    <legend><?php echo $t_animation; ?></legend>
                    <div class="form-group">
                      <label class="col-sm-2 control-label"><?php echo $t_animation_in; ?></label>
                      <div class="col-sm-10">
                        <select name="pdqo_module[settings][window][animation][in]" class="form-control">
                            <option <?php if($settings_window_animation_in == '0') { echo 'selected'; } ?> value="0">Нет эффекта</option>
                            <optgroup label="Attention Seekers">
                              <option <?php if($settings_window_animation_in == 'bounce') { echo 'selected'; } ?> value="bounce">bounce</option>
                              <option <?php if($settings_window_animation_in == 'flash') { echo 'selected'; } ?> value="flash">flash</option>
                              <option <?php if($settings_window_animation_in == 'pulse') { echo 'selected'; } ?> value="pulse">pulse</option>
                              <option <?php if($settings_window_animation_in == 'rubberBand') { echo 'selected'; } ?> value="rubberBand">rubberBand</option>
                              <option <?php if($settings_window_animation_in == 'shake') { echo 'selected'; } ?> value="shake">shake</option>
                              <option <?php if($settings_window_animation_in == 'swing') { echo 'selected'; } ?> value="swing">swing</option>
                              <option <?php if($settings_window_animation_in == 'tada') { echo 'selected'; } ?> value="tada">tada</option>
                              <option <?php if($settings_window_animation_in == 'wobble') { echo 'selected'; } ?> value="wobble">wobble</option>
                              <option <?php if($settings_window_animation_in == 'jello') { echo 'selected'; } ?> value="jello">jello</option>
                            </optgroup>
                            <optgroup label="Bouncing Entrances">
                              <option <?php if($settings_window_animation_in == 'bounceIn') { echo 'selected'; } ?> value="bounceIn">bounceIn</option>
                              <option <?php if($settings_window_animation_in == 'bounceInDown') { echo 'selected'; } ?> value="bounceInDown">bounceInDown</option>
                              <option <?php if($settings_window_animation_in == 'bounceInLeft') { echo 'selected'; } ?> value="bounceInLeft">bounceInLeft</option>
                              <option <?php if($settings_window_animation_in == 'bounceInRight') { echo 'selected'; } ?> value="bounceInRight">bounceInRight</option>
                              <option <?php if($settings_window_animation_in == 'bounceInUp') { echo 'selected'; } ?> value="bounceInUp">bounceInUp</option>
                            </optgroup>
                            <optgroup label="Fading Entrances">
                              <option <?php if($settings_window_animation_in == 'fadeIn') { echo 'selected'; } ?> value="fadeIn">fadeIn</option>
                              <option <?php if($settings_window_animation_in == 'fadeInDown') { echo 'selected'; } ?> value="fadeInDown">fadeInDown</option>
                              <option <?php if($settings_window_animation_in == 'fadeInDownBig') { echo 'selected'; } ?> value="fadeInDownBig">fadeInDownBig</option>
                              <option <?php if($settings_window_animation_in == 'fadeInLeft') { echo 'selected'; } ?> value="fadeInLeft">fadeInLeft</option>
                              <option <?php if($settings_window_animation_in == 'fadeInLeftBig') { echo 'selected'; } ?> value="fadeInLeftBig">fadeInLeftBig</option>
                              <option <?php if($settings_window_animation_in == 'fadeInRight') { echo 'selected'; } ?> value="fadeInRight">fadeInRight</option>
                              <option <?php if($settings_window_animation_in == 'fadeInRightBig') { echo 'selected'; } ?> value="fadeInRightBig">fadeInRightBig</option>
                              <option <?php if($settings_window_animation_in == 'fadeInUp') { echo 'selected'; } ?> value="fadeInUp">fadeInUp</option>
                              <option <?php if($settings_window_animation_in == 'fadeInUpBig') { echo 'selected'; } ?> value="fadeInUpBig">fadeInUpBig</option>
                            </optgroup>

                            <optgroup label="Flippers">
                              <option <?php if($settings_window_animation_in == 'flip') { echo 'selected'; } ?> value="flip">flip</option>
                              <option <?php if($settings_window_animation_in == 'flipInX') { echo 'selected'; } ?> value="flipInX">flipInX</option>
                              <option <?php if($settings_window_animation_in == 'flipInY') { echo 'selected'; } ?> value="flipInY">flipInY</option>
                            </optgroup>

                            <optgroup label="Lightspeed">
                              <option <?php if($settings_window_animation_in == 'lightSpeedIn') { echo 'selected'; } ?> value="lightSpeedIn">lightSpeedIn</option>
                            </optgroup>

                            <optgroup label="Rotating Entrances">
                              <option <?php if($settings_window_animation_in == 'rotateIn') { echo 'selected'; } ?> value="rotateIn">rotateIn</option>
                              <option <?php if($settings_window_animation_in == 'rotateInDownLeft') { echo 'selected'; } ?> value="rotateInDownLeft">rotateInDownLeft</option>
                              <option <?php if($settings_window_animation_in == 'rotateInDownRight') { echo 'selected'; } ?> value="rotateInDownRight">rotateInDownRight</option>
                              <option <?php if($settings_window_animation_in == 'rotateInUpLeft') { echo 'selected'; } ?> value="rotateInUpLeft">rotateInUpLeft</option>
                              <option <?php if($settings_window_animation_in == 'rotateInUpRight') { echo 'selected'; } ?> value="rotateInUpRight">rotateInUpRight</option>
                            </optgroup>

                            <optgroup label="Sliding Entrances">
                              <option <?php if($settings_window_animation_in == 'slideInUp') { echo 'selected'; } ?> value="slideInUp">slideInUp</option>
                              <option <?php if($settings_window_animation_in == 'slideInDown') { echo 'selected'; } ?> value="slideInDown">slideInDown</option>
                              <option <?php if($settings_window_animation_in == 'slideInLeft') { echo 'selected'; } ?> value="slideInLeft">slideInLeft</option>
                              <option <?php if($settings_window_animation_in == 'slideInRight') { echo 'selected'; } ?> value="slideInRight">slideInRight</option>
                             </optgroup>

                            <optgroup label="Zoom Entrances">
                              <option <?php if($settings_window_animation_in == 'zoomIn') { echo 'selected'; } ?> value="zoomIn">zoomIn</option>
                              <option <?php if($settings_window_animation_in == 'zoomInDown') { echo 'selected'; } ?> value="zoomInDown">zoomInDown</option>
                              <option <?php if($settings_window_animation_in == 'zoomInLeft') { echo 'selected'; } ?> value="zoomInLeft">zoomInLeft</option>
                              <option <?php if($settings_window_animation_in == 'zoomInRight') { echo 'selected'; } ?> value="zoomInRight">zoomInRight</option>
                              <option <?php if($settings_window_animation_in == 'zoomInUp') { echo 'selected'; } ?> value="zoomInUp">zoomInUp</option>
                            </optgroup>
                            <optgroup label="Specials">
                              <option <?php if($settings_window_animation_in == 'rollIn') { echo 'selected'; } ?> value="rollIn">rollIn</option>
                            </optgroup>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-sm-2 control-label"><?php echo $t_animation_out; ?></label>
                      <div class="col-sm-10">
                        <select name="pdqo_module[settings][window][animation][out]" class="form-control">
                            <option <?php if($settings_window_animation_out == '0') { echo 'selected'; } ?> value="0">Нет эффекта</option>
                            <optgroup label="Attention Seekers">
                              <option <?php if($settings_window_animation_out == 'bounce') { echo 'selected'; } ?> value="bounce">bounce</option>
                              <option <?php if($settings_window_animation_out == 'flash') { echo 'selected'; } ?> value="flash">flash</option>
                              <option <?php if($settings_window_animation_out == 'pulse') { echo 'selected'; } ?> value="pulse">pulse</option>
                              <option <?php if($settings_window_animation_out == 'rubberBand') { echo 'selected'; } ?> value="rubberBand">rubberBand</option>
                              <option <?php if($settings_window_animation_out == 'shake') { echo 'selected'; } ?> value="shake">shake</option>
                              <option <?php if($settings_window_animation_out == 'swing') { echo 'selected'; } ?> value="swing">swing</option>
                              <option <?php if($settings_window_animation_out == 'tada') { echo 'selected'; } ?> value="tada">tada</option>
                              <option <?php if($settings_window_animation_out == 'wobble') { echo 'selected'; } ?> value="wobble">wobble</option>
                              <option <?php if($settings_window_animation_out == 'jello') { echo 'selected'; } ?> value="jello">jello</option>
                            </optgroup>
                            <optgroup label="Sliding Exits">
                              <option <?php if($settings_window_animation_out == 'slideOutUp') { echo 'selected'; } ?> value="slideOutUp">slideOutUp</option>
                              <option <?php if($settings_window_animation_out == 'slideOutDown') { echo 'selected'; } ?> value="slideOutDown">slideOutDown</option>
                              <option <?php if($settings_window_animation_out == 'slideOutUp') { echo 'selected'; } ?> value="slideOutLeft">slideOutLeft</option>
                              <option <?php if($settings_window_animation_out == 'slideOutRight') { echo 'selected'; } ?> value="slideOutRight">slideOutRight</option>
                            </optgroup>
                            <optgroup label="Bouncing Exits">
                              <option <?php if($settings_window_animation_out == 'bounceOut') { echo 'selected'; } ?> value="bounceOut">bounceOut</option>
                              <option <?php if($settings_window_animation_out == 'bounceOutDown') { echo 'selected'; } ?> value="bounceOutDown">bounceOutDown</option>
                              <option <?php if($settings_window_animation_out == 'bounceOutLeft') { echo 'selected'; } ?> value="bounceOutLeft">bounceOutLeft</option>
                              <option <?php if($settings_window_animation_out == 'bounceOutRight') { echo 'selected'; } ?> value="bounceOutRight">bounceOutRight</option>
                              <option <?php if($settings_window_animation_out == 'bounceOutUp') { echo 'selected'; } ?> value="bounceOutUp">bounceOutUp</option>
                            </optgroup>
                            <optgroup label="Rotating Exits">
                              <option <?php if($settings_window_animation_out == 'rotateOut') { echo 'selected'; } ?> value="rotateOut">rotateOut</option>
                              <option <?php if($settings_window_animation_out == 'rotateOutDownLeft') { echo 'selected'; } ?> value="rotateOutDownLeft">rotateOutDownLeft</option>
                              <option <?php if($settings_window_animation_out == 'rotateOutDownRight') { echo 'selected'; } ?> value="rotateOutDownRight">rotateOutDownRight</option>
                              <option <?php if($settings_window_animation_out == 'rotateOutUpLeft') { echo 'selected'; } ?> value="rotateOutUpLeft">rotateOutUpLeft</option>
                              <option <?php if($settings_window_animation_out == 'rotateOutUpRight') { echo 'selected'; } ?> value="rotateOutUpRight">rotateOutUpRight</option>
                            </optgroup>
                            <optgroup label="Fading Exits">
                              <option <?php if($settings_window_animation_out == 'fadeOut') { echo 'selected'; } ?> value="fadeOut">fadeOut</option>
                              <option <?php if($settings_window_animation_out == 'fadeOutDown') { echo 'selected'; } ?> value="fadeOutDown">fadeOutDown</option>
                              <option <?php if($settings_window_animation_out == 'fadeOutDownBig') { echo 'selected'; } ?> value="fadeOutDownBig">fadeOutDownBig</option>
                              <option <?php if($settings_window_animation_out == 'fadeOutLeft') { echo 'selected'; } ?> value="fadeOutLeft">fadeOutLeft</option>
                              <option <?php if($settings_window_animation_out == 'fadeOutLeftBig') { echo 'selected'; } ?> value="fadeOutLeftBig">fadeOutLeftBig</option>
                              <option <?php if($settings_window_animation_out == 'fadeOutRight') { echo 'selected'; } ?> value="fadeOutRight">fadeOutRight</option>
                              <option <?php if($settings_window_animation_out == 'fadeOutRightBig') { echo 'selected'; } ?> value="fadeOutRightBig">fadeOutRightBig</option>
                              <option <?php if($settings_window_animation_out == 'fadeOutUp') { echo 'selected'; } ?> value="fadeOutUp">fadeOutUp</option>
                              <option <?php if($settings_window_animation_out == 'fadeOutUpBig') { echo 'selected'; } ?> value="fadeOutUpBig">fadeOutUpBig</option>
                            </optgroup>
                            <optgroup label="Zoom Exits">
                              <option <?php if($settings_window_animation_out == 'zoomOut') { echo 'selected'; } ?> value="zoomOut">zoomOut</option>
                              <option <?php if($settings_window_animation_out == 'zoomOutDown') { echo 'selected'; } ?> value="zoomOutDown">zoomOutDown</option>
                              <option <?php if($settings_window_animation_out == 'zoomOutLeft') { echo 'selected'; } ?> value="zoomOutLeft">zoomOutLeft</option>
                              <option <?php if($settings_window_animation_out == 'zoomOutRight') { echo 'selected'; } ?> value="zoomOutRight">zoomOutRight</option>
                              <option <?php if($settings_window_animation_out == 'zoomOutUp') { echo 'selected'; } ?> value="zoomOutUp">zoomOutUp</option>
                            </optgroup>
                            <optgroup label="Flippers">
                              <option <?php if($settings_window_animation_out == 'flipOutX') { echo 'selected'; } ?> value="flipOutX">flipOutX</option>
                              <option <?php if($settings_window_animation_out == 'flipOutY') { echo 'selected'; } ?> value="flipOutY">flipOutY</option>
                            </optgroup>
                            <optgroup label="Lightspeed">
                              <option <?php if($settings_window_animation_out == 'lightSpeedOut') { echo 'selected'; } ?> value="lightSpeedOut">lightSpeedOut</option>
                            </optgroup>
                            <optgroup label="Specials">
                              <option <?php if($settings_window_animation_out == 'hinge') { echo 'selected'; } ?> value="hinge">hinge</option>
                              <option <?php if($settings_window_animation_out == 'rollOut') { echo 'selected'; } ?> value="rollOut">rollOut</option>
                            </optgroup>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $t_animation_duration_out_help; ?>"><?php echo $t_animation_duration_out; ?></span></label>
                      <div class="col-sm-10">
                        <input type="text" name="pdqo_module[settings][window][animation][duration_out]" id="pdqo-settings-window-animation-duration-out" value="<?=$settings_window_animation_duration_out;?>" />
                      </div>
                    </div>
                </fieldset>
            </div>
              
            <div class="tab-pane" id="tab-overlay">
                
              <fieldset>
                <legend><?php echo $t_overlay_tab; ?></legend>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><span data-toggle="tooltip"><?php echo $t_opacity_status; ?></span></label>
                  <div class="col-sm-10">
                    <div class="switch-toggle switch-candy">
                        <input id="off_overlay_opacity_status" name="pdqo_module[settings][overlay][opacity][status]" value="0" type="radio" <?php if($settings_overlay_opacity_status == 0) echo 'checked'; ?>>
                        <label for="off_overlay_opacity_status" onclick=""><?=$t_off;?></label>

                        <input id="on_overlay_opacity_status" name="pdqo_module[settings][overlay][opacity][status]" value="1" type="radio" <?php if($settings_overlay_opacity_status == 1) echo 'checked'; ?>>
                        <label for="on_overlay_opacity_status" onclick=""><?=$t_on;?></label>
                        <a></a>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="pdqo-settings-overlay-color"><?php echo $t_opacity_color; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="pdqo_module[settings][overlay][color]" class="form-control" id="pdqo-settings-overlay-color" value="<?=$settings_overlay_color;?>" />
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="pdqo-settings-overlay-opacity-deep"><?php echo $t_opacity_deep; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="pdqo_module[settings][overlay][opacity][deep]" id="pdqo-settings-overlay-opacity-deep" value="<?=$settings_overlay_opacity_deep;?>" />
                  </div>
                </div>
              </fieldset>
                
              <fieldset>
                <legend><?php echo $t_blur; ?></legend>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><?php echo $t_blur_status; ?></label>
                  <div class="col-sm-10">
                    <div class="switch-toggle switch-candy">
                        <input id="off_overlay_blur_status" name="pdqo_module[settings][overlay][blur][status]" value="0" type="radio" <?php if($settings_overlay_blur_status == 0) echo 'checked'; ?>>
                        <label for="off_overlay_blur_status" onclick=""><?=$t_off;?></label>

                        <input id="on_overlay_blur_status" name="pdqo_module[settings][overlay][blur][status]" value="1" type="radio" <?php if($settings_overlay_blur_status == 1) echo 'checked'; ?>>
                        <label for="on_overlay_blur_status" onclick=""><?=$t_on;?></label>
                        <a></a>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="pdqo-settings-overlay-blur-deep"><?php echo $t_blur_deep; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="pdqo_module[settings][overlay][blur][deep]" id="pdqo-settings-overlay-blur-deep" value="<?=$settings_overlay_blur_deep;?>" />
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $t_blur_element_help; ?>"><?php echo $t_blur_element; ?></span></label>
                  <div class="col-sm-10">
                    <textarea type="text" class="form-control" name="pdqo_module[settings][overlay][blur][element]" placeholder="<?=$t_for_example;?> #container"><?=$settings_overlay_blur_element;?></textarea>
                  </div>
                </div>
              </fieldset>
                
            </div>

            <div class="tab-pane" id="tab-fields">
                
              <fieldset>
                <legend><?php echo $t_field_name; ?></legend>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-return"><span data-toggle="tooltip" title="<?php echo $t_field_status_help; ?>"><?php echo $t_field_status; ?></span></label>
                  <div class="col-sm-10">
                    <div class="switch-toggle switch-candy">
                        <input id="off_field_name_status" name="pdqo_module[settings][fields][name][status]" value="0" type="radio" <?php if($settings_fields_name_status == 0) echo 'checked'; ?>>
                        <label for="off_field_name_status" onclick=""><?=$t_off;?></label>

                        <input id="on_field_name_status" name="pdqo_module[settings][fields][name][status]" value="1" type="radio" <?php if($settings_fields_name_status == 1) echo 'checked'; ?>>
                        <label for="on_field_name_status" onclick=""><?=$t_on;?></label>
                        <a></a>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-return"><span data-toggle="tooltip" title="<?php echo $t_field_required_help; ?>"><?php echo $t_field_required; ?></span></label>
                  <div class="col-sm-10">
                    <div class="switch-toggle switch-candy">
                        <input id="off_field_name_required" name="pdqo_module[settings][fields][name][required]" value="0" type="radio" <?php if($settings_fields_name_required == 0) echo 'checked'; ?>>
                        <label for="off_field_name_required" onclick=""><?=$t_off;?></label>

                        <input id="on_field_name_required" name="pdqo_module[settings][fields][name][required]" value="1" type="radio" <?php if($settings_fields_name_required == 1) echo 'checked'; ?>>
                        <label for="on_field_name_required" onclick=""><?=$t_on;?></label>
                        <a></a>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="pdqo-settings-fields-name-placeholder"><span data-toggle="tooltip" title="<?php echo $t_field_placeholder_help; ?>"><?php echo $t_field_placeholder; ?></span></label>
                  <div class="col-sm-10">
                    <input class="form-control" type="text" name="pdqo_module[settings][fields][name][placeholder]" id="pdqo-settings-fields-name-placeholder" value="<?=$settings_fields_name_placeholder;?>">
                  </div>
                </div>
              </fieldset>
              <fieldset>
                <legend><?php echo $t_field_phone; ?></legend>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-return"><span data-toggle="tooltip" title="<?php echo $t_field_status_help; ?>"><?php echo $t_field_status; ?></span></label>
                  <div class="col-sm-10">
                    <div class="switch-toggle switch-candy">
                        <input id="off_field_phone_status" name="pdqo_module[settings][fields][phone][status]" value="0" type="radio" <?php if($settings_fields_phone_status == 0) echo 'checked'; ?>>
                        <label for="off_field_phone_status" onclick=""><?=$t_off;?></label>

                        <input id="on_field_phone_status" name="pdqo_module[settings][fields][phone][status]" value="1" type="radio" <?php if($settings_fields_phone_status == 1) echo 'checked'; ?>>
                        <label for="on_field_phone_status" onclick=""><?=$t_on;?></label>
                        <a></a>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-return"><span data-toggle="tooltip" title="<?php echo $t_field_required_help; ?>"><?php echo $t_field_required; ?></span></label>
                  <div class="col-sm-10">
                    <div class="switch-toggle switch-candy">
                        <input id="off_field_phone_required" name="pdqo_module[settings][fields][phone][required]" value="0" type="radio" <?php if($settings_fields_phone_required == 0) echo 'checked'; ?>>
                        <label for="off_field_phone_required" onclick=""><?=$t_off;?></label>

                        <input id="on_field_phone_required" name="pdqo_module[settings][fields][phone][required]" value="1" type="radio" <?php if($settings_fields_phone_required == 1) echo 'checked'; ?>>
                        <label for="on_field_phone_required" onclick=""><?=$t_on;?></label>
                        <a></a>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="pdqo-settings-fields-phone-placeholder"><span data-toggle="tooltip" title="<?php echo $t_field_placeholder_help; ?>"><?php echo $t_field_placeholder; ?></span></label>
                  <div class="col-sm-10">
                    <input type="text" class="form-control" name="pdqo_module[settings][fields][phone][placeholder]" id="pdqo-settings-fields-phone-placeholder" value="<?=$settings_fields_phone_placeholder;?>">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="pdqo-settings-fields-phone-mask"><span data-toggle="tooltip" title="<?php echo $t_field_phone_mask_help; ?>"><?php echo $t_field_phone_mask; ?></span></label>
                  <div class="col-sm-10">
                    <input type="text" class="form-control" name="pdqo_module[settings][fields][phone][mask]" id="pdqo-settings-fields-phone-mask" value="<?=$settings_fields_phone_mask;?>">
                  </div>
                </div>
              </fieldset>
              <fieldset>
                <legend><?php echo $t_field_email; ?></legend>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-return"><span data-toggle="tooltip" title="<?php echo $t_field_status_help; ?>"><?php echo $t_field_status; ?></span></label>
                  <div class="col-sm-10">
                    <div class="switch-toggle switch-candy">
                        <input id="off_field_email_status" name="pdqo_module[settings][fields][email][status]" value="0" type="radio" <?php if($settings_fields_email_status == 0) echo 'checked'; ?>>
                        <label for="off_field_email_status" onclick=""><?=$t_off;?></label>

                        <input id="on_field_email_status" name="pdqo_module[settings][fields][email][status]" value="1" type="radio" <?php if($settings_fields_email_status == 1) echo 'checked'; ?>>
                        <label for="on_field_email_status" onclick=""><?=$t_on;?></label>
                        <a></a>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-return"><span data-toggle="tooltip" title="<?php echo $t_field_required_help; ?>"><?php echo $t_field_required; ?></span></label>
                  <div class="col-sm-10">
                    <div class="switch-toggle switch-candy">
                        <input id="off_field_email_required" name="pdqo_module[settings][fields][email][required]" value="0" type="radio" <?php if($settings_fields_email_required == 0) echo 'checked'; ?>>
                        <label for="off_field_email_required" onclick=""><?=$t_off;?></label>

                        <input id="on_field_email_required" name="pdqo_module[settings][fields][email][required]" value="1" type="radio" <?php if($settings_fields_email_required == 1) echo 'checked'; ?>>
                        <label for="on_field_email_required" onclick=""><?=$t_on;?></label>
                        <a></a>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="pdqo-settings-fields-email-placeholder"><span data-toggle="tooltip" title="<?php echo $t_field_placeholder_help; ?>"><?php echo $t_field_placeholder; ?></span></label>
                  <div class="col-sm-10">
                    <input type="text" class="form-control" name="pdqo_module[settings][fields][email][placeholder]" id="pdqo-settings-fields-email-placeholder" value="<?=$settings_fields_email_placeholder;?>">
                  </div>
                </div>
              </fieldset>
              <fieldset>
                <legend><?php echo $t_field_comment; ?></legend>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-return"><span data-toggle="tooltip" title="<?php echo $t_field_status_help; ?>"><?php echo $t_field_status; ?></span></label>
                  <div class="col-sm-10">
                    <div class="switch-toggle switch-candy">
                        <input id="off_field_comment_status" name="pdqo_module[settings][fields][comment][status]" value="0" type="radio" <?php if($settings_fields_comment_status == 0) echo 'checked'; ?>>
                        <label for="off_field_comment_status" onclick=""><?=$t_off;?></label>

                        <input id="on_field_comment_status" name="pdqo_module[settings][fields][comment][status]" value="1" type="radio" <?php if($settings_fields_comment_status == 1) echo 'checked'; ?>>
                        <label for="on_field_comment_status" onclick=""><?=$t_on;?></label>
                        <a></a>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-return"><span data-toggle="tooltip" title="<?php echo $t_field_required_help; ?>"><?php echo $t_field_required; ?></span></label>
                  <div class="col-sm-10">
                    <div class="switch-toggle switch-candy">
                        <input id="off_field_comment_required" name="pdqo_module[settings][fields][comment][required]" value="0" type="radio" <?php if($settings_fields_comment_required == 0) echo 'checked'; ?>>
                        <label for="off_field_comment_required" onclick=""><?=$t_off;?></label>

                        <input id="on_field_comment_required" name="pdqo_module[settings][fields][comment][required]" value="1" type="radio" <?php if($settings_fields_comment_required == 1) echo 'checked'; ?>>
                        <label for="on_field_comment_required" onclick=""><?=$t_on;?></label>
                        <a></a>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="pdqo-settings-fields-comment-placeholder"><span data-toggle="tooltip" title="<?php echo $t_field_placeholder_help; ?>"><?php echo $t_field_placeholder; ?></span></label>
                  <div class="col-sm-10">
                    <input type="text" class="form-control" name="pdqo_module[settings][fields][comment][placeholder]" id="pdqo-settings-fields-comment-placeholder" value="<?=$settings_fields_comment_placeholder;?>">
                  </div>
                </div>
              </fieldset>
                
            </div>
            
            <div class="tab-pane" id="tab-extra">
                
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-return"><span data-toggle="tooltip" title="<?php echo $t_close_by_outside_help; ?>"><?php echo $t_close_by_outside; ?></span></label>
                  <div class="col-sm-10">
                    <div class="switch-toggle switch-candy">
                        <input id="off_close_on_bg_status" name="pdqo_module[settings][extra][close_on_bg][status]" value="0" type="radio" <?php if($settings_extra_close_on_bg_status == 0) echo 'checked'; ?>>
                        <label for="off_close_on_bg_status" onclick=""><?=$t_off;?></label>

                        <input id="on_close_on_bg_status" name="pdqo_module[settings][extra][close_on_bg][status]" value="1" type="radio" <?php if($settings_extra_close_on_bg_status == 1) echo 'checked'; ?>>
                        <label for="on_close_on_bg_status" onclick=""><?=$t_on;?></label>
                        <a></a>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-return"><span data-toggle="tooltip" title="<?php echo $t_close_by_esc_help; ?>"><?php echo $t_close_by_esc; ?></span></label>
                  <div class="col-sm-10">
                    <div class="switch-toggle switch-candy">
                        <input id="off_close_on_esc_status" name="pdqo_module[settings][extra][close_on_esc][status]" value="0" type="radio" <?php if($settings_extra_close_on_esc_status == 0) echo 'checked'; ?>>
                        <label for="off_close_on_esc_status" onclick=""><?=$t_off;?></label>

                        <input id="on_close_on_esc_status" name="pdqo_module[settings][extra][close_on_esc][status]" value="1" type="radio" <?php if($settings_extra_close_on_esc_status == 1) echo 'checked'; ?>>
                        <label for="on_close_on_esc_status" onclick=""><?=$t_on;?></label>
                        <a></a>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-return"><span data-toggle="tooltip" title="<?php echo $t_show_close_button_help; ?>"><?php echo $t_show_close_button; ?></span></label>
                  <div class="col-sm-10">
                    <div class="switch-toggle switch-candy">
                        <input id="off_close_btn_status" name="pdqo_module[settings][extra][close_btn][status]" value="0" type="radio" <?php if($settings_extra_close_btn_status == 0) echo 'checked'; ?>>
                        <label for="off_close_btn_status" onclick=""><?=$t_off;?></label>

                        <input id="on_close_btn_status" name="pdqo_module[settings][extra][close_btn][status]" value="1" type="radio" <?php if($settings_extra_close_btn_status == 1) echo 'checked'; ?>>
                        <label for="on_close_btn_status" onclick=""><?=$t_on;?></label>
                        <a></a>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-return"><span data-toggle="tooltip" title="<?php echo $t_show_close_button_inside_help; ?>"><?php echo $t_show_close_button_inside; ?></span></label>
                  <div class="col-sm-10">
                    <div class="switch-toggle switch-candy">
                        <input id="off_close_btn_inside" name="pdqo_module[settings][extra][close_btn][inside]" value="0" type="radio" <?php if($settings_extra_close_btn_inside == 0) echo 'checked'; ?>>
                        <label for="off_close_btn_inside" onclick=""><?=$t_off;?></label>

                        <input id="on_close_btn_inside" name="pdqo_module[settings][extra][close_btn][inside]" value="1" type="radio" <?php if($settings_extra_close_btn_inside == 1) echo 'checked'; ?>>
                        <label for="on_close_btn_inside" onclick=""><?=$t_on;?></label>
                        <a></a>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-return"><span data-toggle="tooltip" title="<?php echo $t_stick_window_to_top_help; ?>"><?php echo $t_stick_window_to_top; ?></span></label>
                  <div class="col-sm-10">
                    <div class="switch-toggle switch-candy">
                        <input id="off_align_top" name="pdqo_module[settings][extra][align_top][status]" value="0" type="radio" <?php if($settings_extra_align_top_status == 0) echo 'checked'; ?>>
                        <label for="off_align_top" onclick=""><?=$t_off;?></label>

                        <input id="on_align_top" name="pdqo_module[settings][extra][align_top][status]" value="1" type="radio" <?php if($settings_extra_align_top_status == 1) echo 'checked'; ?>>
                        <label for="on_align_top" onclick=""><?=$t_on;?></label>
                        <a></a>
                    </div>
                  </div>
                </div>

            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
<script type="text/javascript"><!--
$("#pdqo-settings-overlay-opacity-deep").ionRangeSlider({
    min: 0,
    max: 1,
    step: 0.1,
    grid: true,
    grid_num: 10
});
$("#pdqo-settings-overlay-blur-deep").ionRangeSlider({
    min: 0,
    max: 20,
    step: 1,
    grid: true,
    grid_num: 20
});
$("#pdqo-settings-window-width").ionRangeSlider({
    min: 400,
    max: 1900,
    step: 10,
    grid: true,
    grid_num: 10
});
$("#pdqo-settings-window-animation-duration-out").ionRangeSlider({
    min: 0,
    max: 2500,
    step: 10,
    grid: true,
    grid_num: 10
});
$('#pdqo-settings-overlay-color').css('background-color', '<?=$settings_overlay_color;?>');
$("#pdqo-settings-overlay-color").ColorPicker({
	color: '<?=$settings_overlay_color;?>',
	onShow: function (colpkr) {
		$(colpkr).fadeIn(500);
		return false;
	},
	onHide: function (colpkr) {
		$(colpkr).fadeOut(500);
		return false;
	},
	onChange: function (hsb, hex, rgb) {
		$('#pdqo-settings-overlay-color').css('background-color', '#' + hex);
        $("#pdqo-settings-overlay-color").val('#' + hex);
	}
});
//--></script>
</div>
<?php echo $footer; ?>