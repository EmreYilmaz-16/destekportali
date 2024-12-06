
<form name="basket-form" id="basket-form">
    <table class="table tbl-basket">
        <tr>
        
        <th  style="width:5%"><a onclick="windowopen('index.cfm?pageinfo=empty_popup_product&ajaxpage=1')"> +</a></th>
        <th  style="width:20%">Ürün Adı</th>
        <th  style="width:20%">Ürün Kodu</th>
        <th  style="width:10%">Miktar</th>
        <th  style="width:10%">Fiyat</th>
        <th  style="width:10%">D.Fiyat</th>
        <th  style="width:5%">Döviz</th>
        <th  style="width:10%">Tutar</th>
         <th  style="width:10%">D.Tutar</th>
        </tr>
        <tbody id="basket-rows"></tbody>
    </table>
    <table><tr><td style="font-weight:bold">Toplam : </td><td style="text-align:right;width:145px;" id="totalArea"></td></td>
</form>     

<script>
var satir=1;
function Hesapla(){
    var toplanTut=0;
    var elems=$(".totprice");
    console.log(elems)
    elems.each(function(index,valu){
        console.log("İndex?"+index);
        var tutar=parseFloat($(valu).val());
        toplanTut=parseFloat(toplanTut)+tutar;
    })
    $("#totalArea").html(toplanTut.toFixed(2))
}
function getSatir(){

return satir;
}
function SetSatir(){
    satir=satir+1;
}
function dellrow(rowid){
$("#row_"+rowid).remove();
 Hesapla();
}
function satirHesapla(rowid){
  var price= $("#price_"+rowid).val();
  var miktar= $("#amount_"+rowid).val();
  var tutar=price*miktar;
  console.log(price);
  console.log(miktar);
  console.log(tutar);
  $("#total_"+rowid).val(tutar);
  Hesapla();
}
</script>