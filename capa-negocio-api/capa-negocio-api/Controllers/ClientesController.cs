using capa_negocio_api.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;
using System.Data;

namespace capa_negocio_api.Controllers
{
    [Route("api/[Controller]")]
    [ApiController]
    public class ClientesController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        private readonly string _connectionString;

        public ClientesController(IConfiguration configuration)
        {
            _configuration = configuration;
            _connectionString = _configuration.GetConnectionString("DefaultConnection");
        }

        // GET: api/clientes
        [HttpGet]
        public IActionResult GetClientes()
        {
            List<Cliente> clientes = new List<Cliente>();

            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("ListarClientes", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    con.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                    {
                        clientes.Add(new Cliente
                        {
                            IdCliente = (int)rdr["IdCliente"],
                            Nombre = rdr["Nombre"].ToString(),
                            Direccion = rdr["Direccion"].ToString(),
                            Telefono = rdr["Telefono"].ToString(),
                            Correo = rdr["Correo"].ToString()
                        });
                    }
                }
            }

            return Ok(clientes);
        }

        // GET: api/clientes/{id}
        [HttpGet("{id}")]
        public IActionResult GetClientes(int id)
        {
            Cliente cliente = null;

            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("ListarClientesPorId", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Id", id);
                    con.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();

                    if (rdr.Read())
                    {
                        cliente = new Cliente
                        {
                            IdCliente = (int)rdr["IdCliente"],
                            Nombre = rdr["Nombre"].ToString(),
                            Direccion = rdr["Direccion"].ToString(),
                            Telefono = rdr["Telefono"].ToString(),
                            Correo = rdr["Correo"].ToString()
                        };
                    }
                }
            }

            if (cliente == null)
            {
                return NotFound();
            }

            return Ok(cliente);
        }

        // POST: api/clientes
        [HttpPost]
        public IActionResult CrearCliente([FromBody] Cliente cliente)
        {
            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("IngresarCliente", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Nombre", cliente.Nombre);
                    cmd.Parameters.AddWithValue("@Direccion", cliente.Direccion);
                    cmd.Parameters.AddWithValue("@Telefono", cliente.Telefono);
                    cmd.Parameters.AddWithValue("@Correo", cliente.Correo);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            return Ok(new { mensaje = "Cliente registrado exitosamente" });
        }
    }
}
