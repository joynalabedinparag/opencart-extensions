<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-filter" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary hide"><i class="fa fa-save"></i></button>
        <button type="button" id="save_description" data-toggle="tooltip" title="Save" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo "Product Description Editor"; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>

  <div class="container-fluid">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo "Product Description Editor"; ?></h3>
      </div>
      <div class="panel-body">
        <div class="col-md-12 row">
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-filter" class="form-horizontal">
              <div class="form-group">
                    <div class="col-md-12 alert msg-wrapper"></div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-status"><?php echo "Category"; ?></label>
                <div class="col-sm-10">
                    <select name="categories" id="category" class="selectpicker form-control category" data-live-search="true" data-title="">
                        <option value="">Select Category </option>
                        <?php foreach($categories as $category) { ?>
                          <option value="<?php echo $category['category_id'];?>"><?php echo $category['name'];?></option>
                        <?php } ?>
                    </select>
                </div>
              </div>

              <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-status"><?php echo "Products"; ?></label>
                  <div class="col-sm-10">
                      <select name="product" id="product" class="form-control product" data-live-search="true" data-title="">
                        <option value="">Select Product</option>
                      </select>
                  </div>
              </div>


              <div class="form-group">
                  <!--<div class="row"> -->
                  <div id="element-container" class="col-sm-10 col-sm-offset-2">

                  </div>
                  <!--</div>-->
                  <div class="row">
                      <div class="col-sm-10 col-sm-offset-2">
                       <button type="button" id="btn-add-row" data-toggle="tooltip" data-original-title="Click To Add Description" class="btn btn-primary pull-right"><i class="fa fa-plus"></i></button>
                      </div>
                  </div>
            </div>

            <input type="hidden" id="product_description" name="product_description" value=""/>
          </form>
      </div>
    </div>
  </div>

    <div id="elements" class="hide">
         <div id="control-width-container">
             <div class="form-group col-sm-offset-4">
                  <label class="" for="input-status"><?php echo "Section Type"; ?></label>
                  <div class="section_element_container">
                      <button type="button" data-toggle="tooltip" title="" class="btn btn-danger remove-temp-container-btn" onclick="" data-original-title="Delete"><i class="fa fa-trash-o"></i></button>
                      <select class="row_type form-control col-sm-10">
                          <option value="">Select Section Type</option>
                          <option value="full-width">Heading & Description</option>
                          <option value="half-width">Heading, Description, Image/Video</option>
                      </select>
                      <div class="elem-width-child col-md-10">

                      </div>
                  </div>
             </div>
          </div>
          <div id="control-full-width">
              <div class="form-group">
                  <label class="col-sm-2" for="input-status">Heading</label>
                  <input type="text" class="elem_h2 form-control col-sm-10" data-type="h2"/>
              </div>
              <div class="form-group">
                  <label class="col-sm-2" for="input-status">Description</label>
                  <textarea type="text" class="elem_p form-control col-sm-10" data-type="p"></textarea>
              </div>
          </div>
          <div id="control-half-width">
              <div class="form-group">
                  <label class="col-sm-2" for="input-status">Heading</label>
                  <input type="text" class="elem_h2 form-control col-sm-10" data-type="h2"/>
              </div>
              <div class="form-group">
                  <label class="col-sm-2" for="input-status">Description</label>
                  <textarea type="text" class="elem_p form-control col-sm-10" data-type="p"></textarea>
              </div>
              <div class="form-group">
                  <label class="col-sm-2" for="input-status">Media Type</label>
                  <select class="form-control col-sm-10 input-media-type">
                      <option value="">Select Media Type</option>
                      <option value="img">Image</option>
                      <option value="vdo">Video</option>
                  </select>
              </div>
              <div class="form-group" style="display:none">
                  <br/>
                  <a href="" id="thumb-image" data-toggle="image" class="img-thumbnail">
                      <img src="<?php echo $image_folder_path;?>cache/no_image-100x100.jpg" alt="" title="" data-placeholder="" />
                  </a>
                  <input type="hidden" name="" value="" class="elem_image" data-type="img" id="input-image"/>
              </div>
              <div class="form-group" style="display:none">
                  <label class="col-md-2" for="input-status">Video Url</label>
                  <input type="text" name="" value="" class="elem_vdo form-control col-md-5" data-type="vdo"/>
              </div>
              <div class="form-group">
                  <label class="col-sm-2" for="input-status">Image/Video Position</label>
                  <select class="form-control col-sm-10 input-image-position">
                      <option value="">Select Image /Video Position</option>
                      <option value="pull-left">Place Left</option>
                      <option value="pull-right">Place Right</option>
                  </select>
              </div>
          </div>
      </div>
  </div>
</div>



<?php echo $footer; ?>
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.6.3/css/bootstrap-select.min.css" />
<script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.6.3/js/bootstrap-select.min.js"></script>

<script>
    $(document).ready(function () {
      var image_folder_path = '<?php echo $image_folder_path;?>';
      var add_row_btn = $("#btn-add-row");
      var element_container = "#element-container";
      var control_width_container = "#control-width-container";
      var remove_temp_container_btn = ".remove-temp-container-btn";
      var elem_width_child = ".elem-width-child";
      var description_row = ".description-row";
      var save_description = "#save_description";
      var msg_wrapper = $(".msg-wrapper");
      add_row_btn.hide();

      add_row_btn.click(function() {
          var data = '<div class="description-row">' + $(control_width_container).html() + '</div>';
          $(element_container).append(data);
      });

      $('body').on('change', '.row_type', function() {
          var elem_width_val = $(this).val();
          $("#control-half-width").find(".elem_image").parent().hide();
          $("#control-half-width").find(".elem_image").val("");
          $("#control-half-width").find(".elem_vdo").parent().hide();
          $("#control-half-width").find(".elem_vdo").val("");
          if(elem_width_val !== "") {
              var control_elements = $("#control-" + elem_width_val).html();
              $(this).parent().find(elem_width_child).html(control_elements);
          }
          $(this).closest(".description-row").attr("data-row-type" , elem_width_val);
          randomlyChangeImageUploaderId();
      });

      $('body').on('click', remove_temp_container_btn, function() {
           $(this).parent().parent().parent().slideUp();
           $(this).parent().parent().parent().remove();
      });

      $('body').on('change', '.input-image-position', function() {
          var img_align = $(this).val();
          var elems = $(this).parent().parent().find("[class*='elem_']");
          $(elems).each(function() {
              if($(this).attr('data-type') == 'img' || $(this).attr('data-type') == 'vdo') {
                if(img_align == 'pull-left') {
                    $(this).attr('data-align', 'pull-left');
                } else {
                    $(this).attr('data-align', 'pull-right');
                }
              } else {
                  if(img_align == 'pull-left') {
                      $(this).attr('data-align', 'pull-right');
                  } else {
                      $(this).attr('data-align', 'pull-left');
                  }
              }
          });
      });

      $('body').on('change', '.input-media-type', function() {
            var media_type = $(this).val();

            if(media_type == 'img') {
                $(this).parent().parent().find('.elem_vdo').parent().hide();
                $(this).parent().parent().find('.elem_image').parent().show();
            } else {
                $(this).parent().parent().find('.elem_vdo').parent().show();
                $(this).parent().parent().find('.elem_image').parent().hide();
            }
            $(this).parent().parent().find('.elem_vdo').val("");
            $(this).parent().parent().find('.elem_image').val("");
            $(this).parent().parent().find('.elem_image').parent().find("img").attr('src', image_folder_path+'cache/no_image-100x100.jpg');
      });

      $('body').on('click', save_description, function() {
          var r = confirm("Previous product description will be replaced by current description format");
          if (r == true) {
              $(".elem_image").each(function () {
                  if ($(this).val().indexOf("http") == -1 && $(this).val() !== "") {
                      $(this).val(image_folder_path + $(this).val());
                  }
              });

              $("#thumb-image").find('img').attr("src");
              $(".elem_image").val();

              var data = "";
              $(description_row).each(function () {
                  var data_row_type = $(this).attr('data-row-type');
                  data += "<div class='row' data-row-type='" + data_row_type + "'>";
                  var row_type = $(this).attr("data-row-type");
                  var elems = $(this).find("[class*='elem_']");

                  $(elems).each(function () {
                      if ($(this).parent().css('display') !== 'none') {
                          var elem_data = $(this).val();
                          var elem_type = $(this).attr("data-type");
                          var elem_align = $(this).attr("data-align");
                          if (elem_type == 'img') {
                              if (elem_data !== "") {
                                  var desc = "<img src='" + elem_data + "' style='max-width: 555px;'/>";
                              } else {
                                  var desc = "";
                              }
                          } else if (elem_type == 'vdo') {
                              if (elem_data !== "") {
                                  if (elem_data.indexOf('youtube') !== -1) {
                                      var desc = '<iframe width="420" height="345" src="' + elem_data + '"></iframe>';
                                      var desc = '<iframe src="' + elem_data + '" frameborder="0" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen="" id="fitvid280297"></iframe>';
                                  } else if (elem_data.indexOf('vimeo') !== -1) {
                                      var desc = '<iframe src="' + elem_data + '" frameborder="0" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen="" id="fitvid280297"></iframe>';
                                  } else {
                                      desc = "";
                                  }
                              } else {
                                  var desc = "";
                              }
                          } else {
                              var desc = "<" + elem_type + ">" + elem_data + "</" + elem_type + ">";
                          }
                          if (row_type == "full-width") {
                              data += desc;
                          } else {
                              if (elem_type !== 'p') {
                                  data += "<div class='col-md-6 " + elem_align + "'>";
                              }
                              data += desc;
                              if (elem_type == 'p' || elem_type == 'img' || elem_type == 'vdo') {
                                  data += "</div>";
                              }
                          }
                      }
                  });
                  data += "</div><br><br>"; // end row
              });

              // console.log(data);

              var cat_id = $("#category").val();
              var product_id = $("#product").val();
              $.ajax({
                  url: "index.php?route=module/product_description_editor/save_description&token=" + getURLVar('token'),
                  type: 'post',
                  dataType: 'html',
                  data: {cat_id : cat_id, product_id : product_id, description : data},
                  cache: false,
                  beforeSend: function () {
                      msg_wrapper.slideDown();
                      msg_wrapper.removeClass('alert-danger').removeClass('alert-success').addClass('alert-info').html("<i class='fa fa-spin fa-refresh'></i> Saving product description. Please wait..");
                  },
                  success: function (response) {
                      msg_wrapper.removeClass('alert-danger').removeClass('alert-info').addClass('alert-success').html("<i class='fa fa-check'></i> Description has been saved successfully.");
                  },
                  error: function (xhr, ajaxOptions, thrownError) {
                      msg_wrapper.removeClass('alert-success').addClass('alert-danger').html("<i class='fa fa-exclamation-triangle' aria-hidden='true'></i> Something went wrong.");
                  }
              });
        } else {

        }
      });

      $('body').on('change', '#product', function() {
          var product_id = $(this).val();
          // console.log(product_id);
          if(product_id !== "") {
              getProductDescription(product_id);
              add_row_btn.slideDown();
          } else {
              $(element_container).html("");
              add_row_btn.slideUp();
          }
      });

      $('body').on('input', '.elem_vdo', function() {
          var url = $(this).val();
          if(url.indexOf("youtube") !== -1) {
              var generated_url = generateYoutubeEmbedUrl(url);
          } else if(url.indexOf("vimeo") !== -1) {
              var generated_url = generateVimeoEmbedUrl(url);
          }
          $(this).val(generated_url);
      });

      $(".category").change(function () {
          var cat_id = $(this).val();
          if(cat_id !== "") {
              loadProducts(cat_id);
          }
      });
      function loadProducts(cat_id) {
        $.ajax({
            url: "index.php?route=module/product_description_editor/getProducts&token=" + getURLVar('token'),
            type: 'post',
            dataType: 'html',
            data: {category_id: cat_id},
            cache: false,
            beforeSend: function () {
                //$("#product").html('<i class="fa fa-refresh fa-spin" aria-hidden="true"></i> Loading');
                $("#product").html('<option value="">Loading Products...</option>');
            },
            success: function (response) {
                $(".product").empty();
                $(".product").html(response);
                // $(".product").selectpicker("refresh");
            },
            error: function (xhr, ajaxOptions, thrownError) {

            }
        });
      }

      function getProductDescription(product_id) {
         $.ajax({
            url: "index.php?route=module/product_description_editor/getProductDescription&token=" + getURLVar('token'),
            type: 'post',
            dataType: 'html',
            data: {product_id : product_id},
            cache: false,
            beforeSend: function () {
                msg_wrapper.hide();
                $(element_container).html("");
                $(element_container).html('<div class="col-md-12 element_container_preloader text-center"><i class="fa fa-refresh fa-spin" aria-hidden="true"></i> Loading..</div>')
            },
            success: function (response) {
              //console.log(response);
                try {
                    parseProductDescriptionNpopulateForm(response);
                } catch(err) {
                    msg_wrapper.removeClass('alert-success').addClass('alert-danger').html("<i class='fa fa-exclamation-triangle' aria-hidden='true'></i> Something went wrong.");
                }
            },
            complete: function() {
               $(".element_container_preloader").remove();
            },
            error: function (xhr, ajaxOptions, thrownError) {

            }
         });
      }

      function parseProductDescriptionNpopulateForm(response) {
          var obj = $.parseHTML( response );
          // console.log(obj);
          $.each( obj, function( i, el ) {
              var row_type = $(this).attr('data-row-type');
              if (typeof row_type !== typeof undefined && row_type !== false) {
                  if (row_type == "full-width") {
                      var full_width_ref_html = $("#control-full-width").clone();
                      full_width_ref_html.attr('id', 'none');
                      full_width_ref_html.find(".elem_h2").val($(this).find('h2').html());
                      full_width_ref_html.find(".elem_p").val($(this).find('p').html());

                      var control_width_container = $("#control-width-container").clone().attr('id', 'none').after("#id");
                      control_width_container.find('.elem-width-child').append(full_width_ref_html);
                      control_width_container.find('.row_type').val(row_type);
                      control_width_container.addClass("description-row");
                      control_width_container.attr('data-row-type', row_type);
                      control_width_container.appendTo(element_container);
                  } else if (row_type == "half-width") {
                      var half_width_ref_html = $("#control-half-width").clone();
                      half_width_ref_html.attr('id', 'none');
                      half_width_ref_html.find(".elem_h2").val($(this).find('h2').html());
                      half_width_ref_html.find(".elem_p").val($(this).find('p').html());

                      var media = "";
                      var media_type = "";
                      if ($(this).find('iframe').length > 0) {
                          media_type = 'vdo';
                      } else if ($(this).find('img').length > 0) {
                          media_type = 'img';
                      }

                      if (media_type == 'vdo') {
                          media = $(this).find('iframe');
                          var elem_media = half_width_ref_html.find(".elem_vdo");
                          var vdo_src = media.attr('src');
                          half_width_ref_html.find(".elem_vdo").val(vdo_src);
                          half_width_ref_html.find(".elem_vdo").parent().show();
                          half_width_ref_html.find(".elem_image").parent().hide();
                          half_width_ref_html.find(".elem_image").val("");
                      } else if (media_type == 'img') {
                          media = $(this).find('img');
                          var elem_media = half_width_ref_html.find(".elem_image");
                          var image_src = media.attr('src');
                          half_width_ref_html.find("img").css('width', '100px');
                          half_width_ref_html.find("img").attr('src', image_src);
                          half_width_ref_html.find(".elem_image").val(image_src);
                          half_width_ref_html.find(".elem_image").parent().show();
                          half_width_ref_html.find(".elem_vdo").val("");
                      }
                      half_width_ref_html.find(".input-media-type").val(media_type);

                      if (media.parent().hasClass('pull-left')) {
                          var media_align = "pull-left";
                          var field_align = "pull-right";
                      } else {
                          var media_align = "pull-right";
                          var field_align = "pull-left";
                      }
                      elem_media.attr('data-align', media_align);
                      half_width_ref_html.find(".elem_h2").attr('data-align', field_align);
                      half_width_ref_html.find(".elem_p").attr('data-align', field_align);

                      half_width_ref_html.find(".input-image-position").val(media_align);

                      var control_width_container = $("#control-width-container").clone().attr('id', 'none').after("#id");
                      control_width_container.find('.elem-width-child').append(half_width_ref_html);
                      control_width_container.find('.row_type').val(row_type);
                      control_width_container.addClass("description-row");
                      control_width_container.attr('data-row-type', row_type);
                      control_width_container.appendTo(element_container);
                      randomlyChangeImageUploaderId();
                  }

              } else {
                  /*
                   if($(this).find("img").length > 0 || $(this).find("iframe").length > 0) {
                        row_type = "half-width";
                   } else {
                        row_type = "full-width";
                   }
                  var elementType = $(this).prop('nodeName');
                  if (typeof elementType !== typeof undefined && elementType !== false) {
                      if (row_type == "full-width") {
                          elementType = elementType.toLowerCase();
                          var full_width_ref_html = $("#control-full-width").clone();
                          full_width_ref_html.attr('id', 'none');
                          if(elementType == "h2") {
                              full_width_ref_html.find(".elem_h2").val($(this).html());
                          } else {
                              full_width_ref_html.find(".elem_p").val($(this).html());
                          }
                          var control_width_container = $("#control-width-container").clone().attr('id', 'none').after("#id");
                          control_width_container.find('.elem-width-child').append(full_width_ref_html);
                          control_width_container.find('.row_type').val(row_type);
                          control_width_container.addClass("description-row");
                          control_width_container.attr('data-row-type', row_type);
                          control_width_container.appendTo(element_container);
                      } else if(row_type == "half-width") {

                      }
                      console.log(elementType);
                  }
                  */
              }
          });
      }

      function randomlyChangeImageUploaderId() {
         /* -- Randomly change image uploader id ---- */
         var element_container =  $("#element-container");
         element_container.find('.img-thumbnail').each(function(index) {
            var random_no = Math.floor((Math.random() * Math.random() * 100) + 1);
            var thumnail_id = $(this).attr('id')+random_no;
            var thumnail_input_id = $(this).parent().find('.elem_image').attr('id')+random_no;
            $(this).attr('id', thumnail_id);
            $(this).attr('data-thumb-id', random_no);
            $(this).parent().find('.elem_image').attr('id', thumnail_input_id);
         });
         /* -- Randomly change image uploader id ----*/
      }

      function generateYoutubeEmbedUrl(url) {
         var regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
         var match = url.match(regExp);

         if (match && match[2].length == 11) {
            var myId =  match[2];
         } else {
            var myId = 'error';
         }
         var myCode = 'http://www.youtube.com/embed/'+ myId;
         return myCode;
      }

      function generateVimeoEmbedUrl(url) {
            var vimeoRegex = /(?:vimeo)\.com.*(?:videos|video|channels|)\/([\d]+)/i;
            var parsed = url.match(vimeoRegex);
            return "http://player.vimeo.com/video/" + parsed[1];
      };

    });
</script>

<style>
.description-row{
    margin-top : 15px;
}

.section_element_container {
    position :relative;
}
.remove-temp-container-btn {
     position :absolute;
     right: 35px;
     top : -15px;
}

.row_type{
    width : 83%;
}
.description-row label {
    padding-left: 0px;
    margin-top : 7px;
}

.section_element_container .form-group {
    margin-bottom: 0;
}
.description-row {
    /*position: relative;*/
    /*margin-bottom : 30px;*/
    border: 1px solid #ddd;
    padding-left: 30px;
}

/*.description-row:after {
    content: "";
    border: 1px solid #000;
    width: 82%;
    bottom: -22px;
    left: 0;
    position: absolute;
}*/

#btn-add-row {
  margin-top : 15px;
  margin-right: 15px;
}

</style>