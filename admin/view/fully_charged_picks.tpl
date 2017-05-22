<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-filter" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo "Fully Charged Picks Section"; ?></h3>
      </div>
      <div class="panel-body">
        <div class="col-md-12" >
            <div class="col-md-10 pull-right">
                <table class="col-md-12 table table-bordered pull-right">
                    <thead>
                    <tr>
                        <th>Category</th>
                        <th>Product(s)</th>
                    </tr>
                    </thead>
                    <tbody>
                    <?php

                          foreach($fully_charged_picks_setting_data as $fd) {
                              if(isset($fd['products'])) {
                                  $product_names = "";
                                  foreach($fd['products'] as $product_id => $pd) {
                                    $product_names .= "<div class='product_label label label-info'>
                                                          ".$pd['name']."
                                                            <span class='remove-product-btn' data-category-id='".$fd['category_id']."' data-product-id='".$pd['product_id']."'>
                                                                <i class='fa fa-times'></i>
                                                            </span>
                                                       </div>";
                                  }
                                  if($product_names != "") {
                                      echo'
                                      <tr>
                                         <td class="col-md-4">
                                            <a href="javascript:void(0)" class="category-checkbox" data-category-id="'.$fd['category_id'].'" data-product-id="'.$product_id.'">'.$fd['category_name'].'</a>
                                         </td>
                                         <td class="col-md-8">'.$product_names.'</td>
                                      </tr>';
                                  } else {
                                      echo'
                                      <tr>
                                         <td colspan="2">No saved settings found.</td>
                                      </tr>';
                                  }
                              }
                          }

                    ?>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="col-md-12 row">
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-filter" class="form-horizontal">
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
                <div class="col-sm-10">
                  <select name="fully_charged_picks_status" id="input-status" class="form-control">
                    <?php if ($fully_charged_picks_status) { ?>
                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                    <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                    <option value="1"><?php echo $text_enabled; ?></option>
                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select>
                </div>
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
                 <label class="col-sm-2 control-label" for="input-status"></label>
                 <div class="col-sm-10 products"> </div>
              </div>
              <input type="hidden" id="fully_charged_picks_settings" name="fully_charged_picks_settings" value="<?php echo $fully_charged_picks_settings;?>"/>
            </form>
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
      addStyles();
      $(".category").change(function () {
          var cat_id = $(this).val();
          if(cat_id !== "") {
              loadProducts(cat_id);
          }
      });

      var arr = new Object();
      var selected_products = $.trim($("#fully_charged_picks_settings").val());
      if(selected_products !== "") {
          var arr = JSON.parse(selected_products);
      }

      $("body").on('click', ".product-list", function () {
         var category_id = $(this).attr('data-category-id');
         var product_id = $(this).attr('data-product-id');
         var selected = $(this).attr('data-selected');
         if(selected == 0) {
             // $(this).css("opacity", ".9");
             $(this).find(".hover_fade_in_back").prepend('<i class="fa fa-check-circle-o fa-3x text-success check-icon"></i>');
             $(this).attr('data-selected', '1');
         } else {
             // $(this).css("opacity", "1");
             $(this).find(".hover_fade_in_back").find(".check-icon").remove();
             $(this).attr('data-selected', '0');
         }
         serializeSelectedProducts(category_id);
      });

      $("body").on('click', ".category-checkbox", function () {
          var category_id = $(this).attr("data-category-id");
          $(".category").val(category_id);
          $(".category").selectpicker('refresh');
          loadProducts(category_id);
      });

      $("body").on('click', ".remove-product-btn", function () {
          $(this).parent().remove();
          var product_id = $(this).attr('data-product-id');
          var category_id = $(this).attr('data-category-id');
          $(".product-list[data-product-id="+product_id+"]").attr("data-selected" , 0);
          $(".product-list[data-product-id='"+product_id+"']").find(".hover_fade_in_back").find(".check-icon").remove();

          var products = arr[category_id];
          var index = products.indexOf(product_id);
          products.splice(index,1);
          arr[category_id] = products;
          var serializedArr = JSON.stringify( arr );
          $("#fully_charged_picks_settings").val( serializedArr );
      });
      function addStyles() {
          // $(".product-list").css("margin", "5px");
      }

      function productListIconRestore() {
          $(".product-list").each(function (index) {
              var product_id = $(this).attr("data-product-id");
              var selected_products =  $("#fully_charged_picks_settings").val();
              if(selected_products.indexOf('"'+product_id+'"') !== -1) {
                  $(this).find(".hover_fade_in_back").prepend('<i class="fa fa-check-circle-o fa-3x text-success check-icon"></i>');
                  $(this).attr('data-selected', '1');
              }
          });
      }

      function getSelectedProducts() {
         var products = [];
         $(".product-list").each(function (index) {
            var product_id = $(this).attr('data-product-id');
            var selected = $(this).attr('data-selected');
            if(selected == 1) {
                products.push(product_id);
            }
         });
        return products;
      }

      function loadProducts(cat_id) {
          $.ajax({
              url: "index.php?route=module/fully_charged_picks/getProducts&token=" + getURLVar('token'),
              type: 'post',
              dataType: 'html',
              data: {category_id: cat_id},
              cache: false,
              beforeSend: function () {
                  $(".products").html('<i class="fa fa-refresh fa-spin" aria-hidden="true"></i> Loading');
              },
              success: function (response) {
                  $(".products").html(response);
                  productListIconRestore();
              },
              error: function (xhr, ajaxOptions, thrownError) {

              }
          });
      }

      function serializeSelectedProducts(category_id) {
          var products = getSelectedProducts();
          arr[category_id] = products;
          if(  products.length == 0 ) {
              delete products[category_id];
          }
          var serializedArr = JSON.stringify( arr );
          $("#fully_charged_picks_settings").val( serializedArr );
      }
  });
</script>
<style>
    .label {
        display: inline-block;
        font-size: 12px;
        color: #1e91cf;
        margin : 5px;
        padding: 3px 0 2px 6px;
        font-weight: normal;
    }
    .label-info {
        background-color: transparent;
        border: 1px solid #aad8f0;
    }
    .label span {
        cursor: pointer;
        font-size: 12px;
        color: #1e91cf;
        border-left: 1px solid #aad8f0;
        padding: 0 6px;
        margin-left: 6px;
    }
    .label span:hover {
        color: red;
    }
    .table tbody > tr > td:first-child {
        font-size:13px;
    }
    .check-icon {
        position :absolute;
    }
</style>