using KasiCuts.Api.Data;
using KasiCuts.Api.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace KasiCuts.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class BarberWorksController : ControllerBase
    {
        private readonly AppDbContext _context;

        public BarberWorksController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<List<BarberWork>>> GetWorks()
        {
            return await _context.BarberWorks
                .OrderByDescending(x => x.CreatedAt)
                .ToListAsync();
        }

        [HttpPost]
        public async Task<ActionResult<BarberWork>> AddWork(BarberWork work)
        {
            _context.BarberWorks.Add(work);
            await _context.SaveChangesAsync();

            return Ok(work);
        }
    }
}