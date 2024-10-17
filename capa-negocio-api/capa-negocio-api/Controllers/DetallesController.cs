using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;
using System.Data;
using capa_negocio_api.Models;

namespace capa_negocio_api.Controllers
{
    [Route("api/[Controller]")]
    [ApiController]
    public class DetallesController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        private readonly string _connectionString;

        public DetallesController(IConfiguration configuration)
        {
            _configuration = configuration;
            _connectionString = _configuration.GetConnectionString("DefaultConnection");
        }

        // GET: api/detalles
        [HttpGet]
        public IActionResult GetDetalles()
        {
            List<DetalleFactura> detallesFacturas = new List<DetalleFactura>();

            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("ListarDetalleFactura", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    con.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                    {
                        detallesFacturas.Add(new DetalleFactura
                        {
                            IdDetalle = (int)rdr["IdDetalle"],
                            IdFactura = (int)rdr["IdFactura"],
                            IdProducto = (int)rdr["IdProducto"],
                            Cantidad = (int)rdr["Cantidad"],
                            PrecioUnitario = (decimal)rdr["PrecioUnitario"]
                        });
                    }
                }
            }

            return Ok(detallesFacturas);
        }

        // GET: api/detalles/{id}
        [HttpGet("{id}")]
        public IActionResult GetDetalles(int id)
        {
            DetalleFactura detalleFactura = null;

            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("ListarDetallesPorId", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Id", id);
                    con.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();

                    if (rdr.Read())
                    {
                        detalleFactura = new DetalleFactura
                        {
                            IdDetalle = (int)rdr["IdDetalle"],
                            IdFactura = (int)rdr["IdFactura"],
                            IdProducto = (int)rdr["IdProducto"],
                            Cantidad = (int)rdr["Cantidad"],
                            PrecioUnitario = (decimal)rdr["PrecioUnitario"]
                        };
                    }
                }
            }

            if (detalleFactura == null)
            {
                return NotFound();
            }

            return Ok(detalleFactura);
        }

        // POST: api/detalles
        [HttpPost]
        public IActionResult CrearDetalle([FromBody] DetalleFactura detalleFactura)
        {
            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("IngresarDetalleFactura", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@IdFactura", detalleFactura.IdFactura);
                    cmd.Parameters.AddWithValue("@IdProducto", detalleFactura.IdProducto);
                    cmd.Parameters.AddWithValue("@Cantidad", detalleFactura.Cantidad);
                    cmd.Parameters.AddWithValue("@PrecioUnitario", detalleFactura.PrecioUnitario);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            return Ok(new { mensaje = "Detalle registrado exitosamente" });
        }

        // PUT: api/detalles/{id}
        [HttpPut("{id}")]
        public IActionResult ActualizarDetalles(int id, [FromBody] DetalleFactura detalle)
        {
            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("ActualizarDetalle", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@IdDetalle", id);
                    cmd.Parameters.AddWithValue("@IdFactura", detalle.IdFactura);
                    cmd.Parameters.AddWithValue("@IdProducto", detalle.IdProducto); 
                    cmd.Parameters.AddWithValue("@Cantidad", detalle.Cantidad);
                    cmd.Parameters.AddWithValue("@PrecioUnitario", detalle.PrecioUnitario);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            return Ok(new { mensaje = "Detalle actualizado exitosamente" });
        }
    }
}
