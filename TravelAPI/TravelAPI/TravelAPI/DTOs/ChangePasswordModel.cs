namespace TravelAPI.DTOs
{
    public class ChangePasswordModel
    {
        public int UserId { get; set; }
        public string NewPassword { get; set; }
    }
}
