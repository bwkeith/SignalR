using KanbanBoard.Models;
using Microsoft.AspNet.SignalR;
using System.Linq;

namespace KanbanBoard.Hubs
{
    public class CardHub : Hub
    {
	    public void Demote(long cardId)
	    {
			var dc = new KanbanBoardDataContext();

			var card = dc.Cards.FirstOrDefault(c => c.Id == cardId);
			if (card != null)
			{
				var cachedBoardId = card.Board.Id;

				var previousBoard = dc.Boards.FirstOrDefault(b => b.Id == card.Board.Previous);
				if (previousBoard != null)
				{
					card.Board = previousBoard;
					dc.SubmitChanges();

					Clients.All.onCardChanged(cardId, "BoardId", cachedBoardId, card.Board.Id);
				}
			}
	    }

	    public void Promote(long cardId)
	    {
			var dc = new KanbanBoardDataContext();

			var card = dc.Cards.FirstOrDefault(c => c.Id == cardId);
			if (card != null)
			{
				var cachedBoardId = card.Board.Id;

				var nextBoard = dc.Boards.FirstOrDefault(b => b.Id == card.Board.Next);
				if (nextBoard != null)
				{
					card.Board = nextBoard;
					dc.SubmitChanges();

					Clients.All.onCardChanged(cardId, "BoardId", cachedBoardId, card.Board.Id);
				}
			}
	    }
    }
}