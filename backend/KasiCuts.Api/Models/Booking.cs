namespace KasiCuts.Api.Models
{
    public class Booking
    {
        public int Id { get; set; }

        public string CustomerName { get; set; } = string.Empty;

        public string CustomerPhone { get; set; } = string.Empty;

        public int ServiceId { get; set; }

        public DateTime BookingDate { get; set; }

        public int BarberId { get; set; }

        public bool IsHouseCall { get; set; }

        public string Status { get; set; } = "Pending";

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    }
}