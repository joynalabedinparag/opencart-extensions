<?php
class ControllerModuleFullyChargedPicks extends Controller {
	private $error = array();

	public function index() {
		$this->load->model('catalog/product');
		$this->load->language('module/fully_charged_picks');

		$this->load->model('setting/setting');
		$data = array();
		$parts = explode('_', (string)$this->request->get['path']);
		$category_id = (int)array_pop($parts);

		$fully_charged_picks= $this->config->get('fully_charged_picks_settings');
		$fully_charged_picks = html_entity_decode($fully_charged_picks);
		$fully_charged_picks = json_decode($fully_charged_picks, true);
		if(isset($fully_charged_picks[$category_id])) {
			$fully_charged_picks = $fully_charged_picks[$category_id];

			$products = array();
			foreach ($fully_charged_picks as $fully_charged_pick) {
				$products[] = $this->model_catalog_product->getProduct($fully_charged_pick);
			}

			$url = '';
			foreach ($products as $product) {
				if ($product['image']) {
					$image = $this->model_tool_image->resize($product['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
				} else {
					$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
				}

				if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$price = false;
				}

				if ((float)$product['special']) {
					$special = $this->currency->format($this->tax->calculate($product['special'], $product['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$special = false;
				}

				if ($this->config->get('config_tax')) {
					$tax = $this->currency->format((float)$product['special'] ? $product['special'] : $product['price']);
				} else {
					$tax = false;
				}

				if ($this->config->get('config_review_status')) {
					$rating = (int)$product['rating'];
				} else {
					$rating = false;
				}

				$data['products'][] = array(
					'product_id' => $product['product_id'],
					'thumb' => $image,
					'name' => $product['name'],
					'description' => utf8_substr(strip_tags(html_entity_decode($product['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
					'price' => $price,
					'quantity' => $product['quantity'],
					'special' => $special,
					'tax' => $tax,
					'rating' => $product['rating'],
					'href' => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $product['product_id'] . $url)
				);
			}
			$data['button_wishlist'] = $this->language->get('button_wishlist');
			$data['button_compare'] = $this->language->get('button_compare');
			$data['button_cart'] = $this->language->get('button_cart');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/fully_charged_picks.tpl')) {
				return $this->load->view($this->config->get('config_template') . '/template/module/fully_charged_picks.tpl', $data);
			} else {
				return $this->load->view('default/template/common/content_middle.tpl', $data);
			}
		}
	}
}