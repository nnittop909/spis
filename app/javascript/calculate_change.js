function calculateChange() {
  var totalAmount = document.getElementById('total').value;
  var cashTendered = document.getElementById('orders_processor_cash_tendered').value;
  var discount = document.getElementById('orders_processor_discount_amount').value;

  var change = document.getElementById('orders_processor_change');
  var myResult = cashTendered - (totalAmount - parseFloat(discount));
  change.value = myResult;
}