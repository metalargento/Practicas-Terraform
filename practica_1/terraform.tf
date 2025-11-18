resource "local_file" "productos" {
  content  = "Lista de productos para el proximo mes"
  filename = "products.txt"
}
