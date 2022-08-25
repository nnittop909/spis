function calculateTotalPurchase() {
  var quantity = document.getElementById('stock_processor_quantity').value;
  var unitCost = document.getElementById('stock_processor_unit_cost').value;
  var discount = document.getElementById('stock_processor_discount_amount').value;
  var freight = document.getElementById('stock_processor_freight_amount').value;

  var totalCost = document.getElementById('stock_processor_total_cost');
  var myResult = (quantity * unitCost) + freight - discount;
  totalCost.value = myResult;
}
