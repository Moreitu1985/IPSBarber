namespace KasiCuts.Api.Models
{
    public class Barber
    {
        public int Id { get; set; }

        public string FullName { get; set; } = string.Empty;

        public string ShopName { get; set; } = string.Empty;

        public string PhoneNumber { get; set; } = string.Empty;

        public string Location { get; set; } = string.Empty;

        public decimal Rating { get; set; } = 0;

        public bool IsAvailable { get; set; } = true;

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    }
}