resource "local_file" "productos" {
    count = 3
    content = "Lista de productos para el proximo mes"
    filename = "products-${random_string.sufijo[count.index].id}.txt"
}

