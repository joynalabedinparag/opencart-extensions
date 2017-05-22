<?php
class ControllerModuleProductDescriptionEditor extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('module/fully_charged_picks');

		$this->load->model('setting/setting');
		$this->load->model('module/product_description_editor');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
	
			$this->response->redirect($this->url->link('module/product_description_editor', 'token=' . $this->session->data['token'], 'SSL'));
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
			'text' => "Product Description Editor",
			'href' => $this->url->link('module/product_description_editor', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['action'] = $this->url->link('module/product_description_editor', 'token=' . $this->session->data['token'], 'SSL');
		$data['image_folder_path'] = "http://".$_SERVER['SERVER_NAME']."/fullychargedv3/image/";

		$filter_data = array();
		$results = $this->model_module_product_description_editor->getCategories($filter_data);
		foreach ($results as $result) {
			$data['categories'][] = array(
				'category_id' => $result['category_id'],
				'name'        => $result['name'],
			);
		}

		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/product_description_editor.tpl', $data));
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
				'quantity'	  => $result['quantity'],
				'rating'      => $result['rating'],
				'href'        => "javascript:void(0)"
			);
		}

		$products_options = "";
		if(!empty($products)) {
			$products_options .= '<option value="">Select Product</option>';
			foreach ($products as $product) {
				$products_options .= '<option value="'.$product['product_id'].'">'.$product['name'].'</option>';
			}
		} else {
			$products_options .= '<option value="">No Product Found Under This Category</option>';
		}
		echo $products_options;
	}

	public function save_description() {
		$this->load->model('module/product_description_editor');
		$data['category_id'] = $this->request->post['cat_id'];
		$data['product_id'] = $this->request->post['product_id'];
		$data['description'] = $this->request->post['description'];
		$results = $this->model_module_product_description_editor->saveProductDescription($data);
	}

	public function getProductDescription() {
		$this->load->model('module/product_description_editor');
		$product_id = $this->request->post['product_id'];
		$description = $this->model_module_product_description_editor->getProductDescription($product_id);
		echo $description = html_entity_decode($description);
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/fully_charged_picks')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
}