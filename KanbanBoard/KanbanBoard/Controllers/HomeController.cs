using KanbanBoard.Models;
using System.Web.Mvc;

namespace KanbanBoard.Controllers
{
	public class HomeController : Controller
	{
		public ActionResult Index()
		{
			var dc = new KanbanBoardDataContext();

			var boards = dc.Boards;

			return View(boards);
		}
	}
}