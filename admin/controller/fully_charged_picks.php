<?php
class ControllerModuleFullyChargedPicks extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('module/fully_charged_picks');

		$this->load->model('setting/setting');
		$this->load->model('module/fully_charged_picks');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('fully_charged_picks', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('module/fully_charged_picks', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$data['heading_title'] = $this->language->get('heading_title');
		
		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');

		$data['entry_status'] = $this->language->get('entry_status');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_module'),
			'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('module/filter', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['action'] = $this->url->link('module/fully_charged_picks', 'token=' . $this->session->data['token'], 'SSL');

		$data['fully_charged_picks_status'] = $this->config->get('fully_charged_picks_status');
		$data['fully_charged_picks_settings'] = $this->config->get('fully_charged_picks_settings');
		$fully_charged_settings = html_entity_decode($this->config->get('fully_charged_picks_settings'));
		$fully_charged_settings = json_decode($fully_charged_settings, true);
		$current_settings_data = array();
		if(!empty($fully_charged_settings)) {
			foreach ($fully_charged_settings as $category_id => $products) {
				$category_info = $this->model_module_fully_charged_picks->getCategory($category_id);
				$current_settings_data[$category_id]['category_id'] = $category_id;
				$current_settings_data[$category_id]['category_name'] = $category_info['name'];
				foreach ($products as $product_id) {
					$product_info = $this->model_module_fully_charged_picks->getProduct($product_id);
					$current_settings_data[$category_id]['products'][] = $product_info;
				}
			}
		}
		$data['fully_charged_picks_setting_data'] = $current_settings_data;

		$filter_data = array();
		$results = $this->model_module_fully_charged_picks->getCategories($filter_data);
		foreach ($results as $result) {
			$data['categories'][] = array(
				'category_id' => $result['category_id'],
				'name'        => $result['name'],
				// 'sort_order'  => $result['sort_order'],
			);
		}

		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/fully_charged_picks.tpl', $data));
	}

	public function getProducts() {
		$this->load->model('module/fully_charged_picks');
		$this->load->model('tool/image');
		$products = array();
		$category_id = $this->request->post['category_id'];

		$filter_data = array(
			'filter_category_id' => $category_id,
		);

		$results = $this->model_module_fully_charged_picks->getProducts($filter_data);
		foreach ($results as $result) {
			if ($result['image']) {
				$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
			} else {
				$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
			}

			$products[] = array (
				'product_id'  => $result['product_id'],
				'thumb'       => $image,
				'name'        => $result['name'],
				'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
				//'price'       => $price,
				'quantity'	  => $result['quantity'],
				//'special'     => $special,
				//'tax'         => $tax,
				'rating'      => $result['rating'],
				'href'        => "javascript:void(0)"
			);
		}

		if(!empty($products)) {
			?>
			<div class="row">
				<?php foreach ($products as $product) { ?>
					<div data-category-id="<?php echo $category_id; ?>"
						 data-product-id="<?php echo $product['product_id']; ?>" data-selected="0"
						 class="product-layout product-list col-md-4 col-xs-12">
						<div class="product-thumb">
							<div class="inner">
								<div class="inner2">
									<div class="image hover_fade_in_back">
										<?php if ($product['thumb'] && isset($product['thumb_swap']) && $config->get('clearshop_rollover_images') == 1) { ?>
											<div class="front-image">
												<a href="<?php echo $product['href']; ?>"><img
														src="<?php echo $product['thumb']; ?>"
														title="<?php echo $product['name']; ?>" class="img-responsive"
														alt="<?php echo $product['name']; ?>"/></a>
											</div>
											<div class="back-image">
												<a href="<?php echo $product['href']; ?>"><img
														src="<?php echo $product['thumb_swap']; ?>"
														title="<?php echo $product['name']; ?>" class="img-responsive"
														alt="<?php echo $product['name']; ?>"/></a>
											</div>
										<?php } else if ($product['thumb']) { ?>
											<a href="<?php echo $product['href']; ?>"><img
													src="<?php echo $product['thumb']; ?>"
													title="<?php echo $product['name']; ?>" class="img-responsive"
													alt="<?php echo $product['name']; ?>"/></a>
										<?php } ?>
									</div>

									<div>
										<div class="caption text-center">
											<h4 class="name"><a
													href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
											</h4>
											<p class="description hide"><?php echo $product['description']; ?></p>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

				<?php } ?>
			</div>
			<?php
		} else { ?>
			<div class="alert alert-warning">No Product Found Under This Category</div>
		<?php
		}
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/fully_charged_picks')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
}