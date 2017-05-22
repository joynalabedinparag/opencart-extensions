<!--<div class="box"> -->
	
	<h1 class="page-header"><?php echo "Fully Charged Picks"; ?></h1>

	<div class="row">
		<?php foreach ($products as $product) { ?>
		<div class="product-layout product-list col-md-4 col-xs-12">
			<div class="product-thumb">
				<div class="inner">
					<div class="inner2">
						<div class="image hover_fade_in_back">
							<?php if ( $product['thumb'] && isset($product['thumb_swap']) && $config->get('clearshop_rollover_images')==1) { ?>
							<div class="front-image">
								<a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" alt="<?php echo $product['name']; ?>"/></a>
							</div>
							<div class="back-image">
								<a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb_swap']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" alt="<?php echo $product['name']; ?>"/></a>
							</div>
							<?php } else if ($product['thumb']) { ?>
							<a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" alt="<?php echo $product['name']; ?>" /></a>
							<?php } ?>
						</div>

						<div>
							<div class="caption">
								<?php if ($product['price'] && $product['special']) { ?>
								<div class="onsale"><span><?php echo $language->get('text_onsale'); ?></span></div>
								<?php } ?>

								<h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
								<p class="description"><?php echo $product['description']; ?></p>

								<?php if ($product['rating']) { ?>
								<div class="rating">
									<?php for ($i = 1; $i <= 5; $i++) { ?>
									<?php if ($product['rating'] < $i) { ?>
									<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
									<?php } else { ?>
									<span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
									<?php } ?>
									<?php } ?>
								</div>
								<?php } ?>
								<?php if ($product['price']) { ?>
								<p class="price">
									<?php if (!$product['special']) { ?>
									<?php echo $product['price']; ?>
									<?php } else { ?>
									<span class="price-new"><?php echo $product['special']; ?></span> <span class="price-old"><?php echo $product['price']; ?></span>
									<?php } ?>
									<?php if ($product['tax']) { ?>
									<span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
									<?php } ?>
								</p>
								<?php } ?>

								<div class="cart"><button type="button" onclick="cart.add('<?php echo $product['product_id']; ?>');" class="btn btn-default btn-sm"><?php echo $button_cart; ?></button></div>

								<div class="links">
									<span class="wishlist"><a onclick="wishlist.add('<?php echo $product['product_id']; ?>');" title="<?php echo $button_wishlist; ?>" class="tooltp" ><i class="fa fa-heart"></i></a></span>

									<span class="compare"><a onclick="compare.add('<?php echo $product['product_id']; ?>');" title="<?php echo $button_compare; ?>" class="tooltp" ><i class="fa fa-plus"></i></a></span>
								</div>

							</div>

						</div>
					</div>
				</div>
			</div>
		</div>
		<?php } ?>
	</div>

<br />
<br />
<!-- </div> -->
