<?php
class ModelModuleProductDescriptionEditor extends Model {

  public function saveProductDescription($data = array()) {
    $sql = "UPDATE " . DB_PREFIX . "product_description SET `description` = '".$this->db->escape($data['description'])."'
            WHERE `product_id` = '".$data['product_id']."'";
    $query = $this->db->query($sql);
  }

  public function getProductDescription($product_id) {
    $sql = "SELECT `description` FROM  " . DB_PREFIX . "product_description WHERE `product_id` = '".$product_id."'";
    $query = $this->db->query($sql);
    return $query->row['description'];
  }

  public function getCategories($data = array()) {
    $sql = "SELECT cp.category_id AS category_id, GROUP_CONCAT(cd1.name ORDER BY cp.level SEPARATOR '&nbsp;&nbsp;&gt;&nbsp;&nbsp;') AS name, c1.parent_id, c1.sort_order FROM " . DB_PREFIX . "category_path cp LEFT JOIN " . DB_PREFIX . "category c1 ON (cp.category_id = c1.category_id) LEFT JOIN " . DB_PREFIX . "category c2 ON (cp.path_id = c2.category_id) LEFT JOIN " . DB_PREFIX . "category_description cd1 ON (cp.path_id = cd1.category_id) LEFT JOIN " . DB_PREFIX . "category_description cd2 ON (cp.category_id = cd2.category_id) WHERE cd1.language_id = '" . (int)$this->config->get('config_language_id') . "' AND cd2.language_id = '" . (int)$this->config->get('config_language_id') . "'";

    if (!empty($data['filter_name'])) {
      $sql .= " AND cd2.name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
    }
    $sql .= " GROUP BY cp.category_id ORDER BY name ASC";

    $query = $this->db->query($sql);

    return $query->rows;
  }
}

?>