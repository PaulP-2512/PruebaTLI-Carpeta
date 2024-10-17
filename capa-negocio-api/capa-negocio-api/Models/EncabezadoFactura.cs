namespace capa_negocio_api.Models
{
    public class EncabezadoFactura
    {
        public int IdFactura { get; set; }
        public int IdCliente { get; set; }
        public DateTime Fecha { get; set; }
        public decimal Total { get; set; }
    }
}
