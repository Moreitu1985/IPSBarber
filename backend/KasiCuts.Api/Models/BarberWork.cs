namespace KasiCuts.Api.Models
{
    public class BarberWork
    {
        public int Id { get; set; }

        public int BarberId { get; set; }

        public string BarberName { get; set; } = string.Empty;

        public string StyleName { get; set; } = string.Empty;

        public string Description { get; set; } = string.Empty;

        public string ImageUrl { get; set; } = string.Empty;

        public decimal PriceFrom { get; set; }

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    }
}