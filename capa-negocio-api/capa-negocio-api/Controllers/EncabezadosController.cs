using capa_negocio_api.Models;
using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;
using System.Data;

namespace capa_negocio_api.Controllers
{
    [Route("api/[Controller]")]
    [ApiController]
    public class EncabezadosController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        private readonly string _connectionString;

        public EncabezadosController(IConfiguration configuration)
        {
            _configuration = configuration;
            _connectionString = _configuration.GetConnectionString("DefaultConnection");
        }

        // GET: api/encabezados
        [HttpGet]
        public IActionResult GetEncabezados()
        {
            List<EncabezadoFactura> encabezadosFacturas = new List<EncabezadoFactura>();

            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("ListarEncabezadoFactura", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    con.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                    {
                        encabezadosFacturas.Add(new EncabezadoFactura
                        {
                            IdFactura = (int)rdr["IdFactura"],
                            IdCliente = (int)rdr["IdCliente"],
                            Fecha = (DateTime)rdr["Fecha"],
                            Total = (decimal)rdr["Total"]
                        });
                    }
                }
            }

            return Ok(encabezadosFacturas);
        }

        // GET: api/encabezados/{id}
        [HttpGet("{id}")]
        public IActionResult GetEncabezado(int id)
        {
            EncabezadoFactura encabezadosFacturas = null;

            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("ListarEncabezadosPorId", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Id", id);
                    con.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();

                    if (rdr.Read())
                    {
                        encabezadosFacturas = new EncabezadoFactura
                        {
                            IdFactura = (int)rdr["IdFactura"],
                            IdCliente = (int)rdr["IdCliente"],
                            Fecha = (DateTime)rdr["Fecha"],
                            Total = (decimal)rdr["Total"]
                        };
                    }
                }
            }

            if (encabezadosFacturas == null)
            {
                return NotFound();
            }

            return Ok(encabezadosFacturas);
        }

        // POST: api/encabezados
        [HttpPost]
        public IActionResult CrearEncabezado([FromBody] EncabezadoFactura encabezadoFactura)
        {
            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("IngresarEncabezadoFactura", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@IdCliente", encabezadoFactura.IdCliente);
                    cmd.Parameters.AddWithValue("@Fecha", encabezadoFactura.Fecha);
                    cmd.Parameters.AddWithValue("@Total", encabezadoFactura.Total);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            return Ok(new { mensaje = "Factura registrada exitosamente" });
        }
    }
}
