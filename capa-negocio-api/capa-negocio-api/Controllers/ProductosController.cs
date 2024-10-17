using capa_negocio_api.Models;
using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;
using System.Data;

namespace capa_negocio_api.Controllers
{
    [Route("api/[Controller]")]
    [ApiController]
    public class ProductosController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        private readonly string _connectionString;

        public ProductosController(IConfiguration configuration)
        {
            _configuration = configuration;
            _connectionString = _configuration.GetConnectionString("DefaultConnection");
        }

        // GET: api/productos
        [HttpGet]
        public IActionResult GetProductos()
        {
            List<Producto> productos = new List<Producto>();

            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("ListarProductos", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    con.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                    {
                        productos.Add(new Producto
                        {
                            IdProducto = (int)rdr["IdProducto"],
                            Nombre = rdr["Nombre"].ToString(),
                            Precio = (decimal)rdr["Precio"],
                            Stock = (int)rdr["Stock"]
                        });
                    }
                }
            }

            return Ok(productos);
        }

        // GET: api/productos/{id}
        [HttpGet("{id}")]
        public IActionResult GetProductos(int id)
        {
            Producto producto = null;

            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("ListarProductosPorId", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Id", id);
                    con.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();

                    if (rdr.Read())
                    {
                        producto = new Producto
                        {
                            IdProducto = (int)rdr["IdProducto"],
                            Nombre = rdr["Nombre"].ToString(),
                            Precio = (decimal)rdr["Precio"],
                            Stock = (int)rdr["Stock"]
                        };
                    }
                }
            }

            if (producto == null)
            {
                return NotFound();
            }

            return Ok(producto);
        }

        // POST: api/productos
        [HttpPost]
        public IActionResult CrearProducto([FromBody] Producto producto)
        {
            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("IngresarProducto", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Nombre", producto.Nombre);
                    cmd.Parameters.AddWithValue("@Precio", producto.Precio);
                    cmd.Parameters.AddWithValue("@Stock", producto.Stock);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            return Ok(new { mensaje = "Producto registrado exitosamente" });
        }
    }
}
