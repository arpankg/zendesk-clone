import { useNavigate, useParams } from 'react-router-dom';
import { useTickets } from '../../hooks/useTickets';
import { formatMessageDate } from '../../lib/utils';
import { useMemo, useState } from 'react';
import { supabase } from '../../../config/supabase';

export function TicketListPanel() {
  const { tickets, loading, error } = useTickets();
  const [showAllTickets, setShowAllTickets] = useState(false);
  const navigate = useNavigate();
  const { id: currentTicketId } = useParams();
  const [currentUser, setCurrentUser] = useState<{ id: string } | null>(null);

  // Fetch current user on component mount
  useMemo(() => {
    async function getCurrentUser() {
      const { data: { user } } = await supabase.auth.getUser();
      if (user) {
        setCurrentUser(user);
      }
    }
    getCurrentUser();
  }, []);

  // Filter tickets based on toggle state
  const displayedTickets = useMemo(() => {
    if (showAllTickets || !currentUser?.id) return tickets;
    return tickets.filter(ticket => 
      ticket.assigned_to?.includes(currentUser.id)
    );
  }, [tickets, showAllTickets, currentUser?.id]);

  if (loading) {
    return (
      <div className="h-full flex items-center justify-center">
        <div className="text-gray-500">Loading tickets...</div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="h-full flex items-center justify-center">
        <div className="text-red-500">Error loading tickets</div>
      </div>
    );
  }

  return (
    <div className="h-full flex flex-col bg-white">
      <div className="shrink-0 p-4 border-b border-gray-200 space-y-4">
        <div className="relative">
          <input
            type="text"
            placeholder="Search tickets..."
            className="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
          />
          <svg
            className="absolute left-3 top-2.5 h-5 w-5 text-gray-400"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              strokeWidth={2}
              d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
            />
          </svg>
        </div>

        {/* Toggle for assigned/all tickets */}
        <div className="flex items-center justify-between">
          <label className="relative inline-flex items-center cursor-pointer">
            <input
              type="checkbox"
              className="sr-only peer"
              checked={showAllTickets}
              onChange={(e) => setShowAllTickets(e.target.checked)}
            />
            <div className="w-11 h-6 bg-gray-200 peer-focus:outline-none peer-focus:ring-4 peer-focus:ring-blue-300 rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-blue-600"></div>
            <span className="ml-3 text-sm font-medium text-gray-700">
              {showAllTickets ? 'Viewing all tickets' : 'Viewing assigned tickets'}
            </span>
          </label>
        </div>
      </div>
      
      <div className="flex-1 overflow-y-auto">
        {displayedTickets.length === 0 ? (
          <div className="p-4 text-center text-gray-500">
            {showAllTickets ? 'No tickets found' : 'No tickets assigned to you'}
          </div>
        ) : (
          displayedTickets.map((ticket) => {
            const isSelected = ticket.id === currentTicketId;
            
            return (
              <div
                key={ticket.id}
                className={`
                  p-4 border-b border-gray-200 cursor-pointer
                  ${isSelected ? 'bg-blue-50' : 'hover:bg-gray-50'}
                `}
                onClick={() => navigate(`/employee-dashboard/ticket/${ticket.id}`)}
              >
                <div className="flex flex-col space-y-2">
                  <div className="flex items-center space-x-2">
                    <div className={`
                      w-2 h-2 rounded-full
                      ${ticket.status === 'open' ? 'bg-green-500' : 'bg-gray-500'}
                    `} />
                    <h3 className="text-sm font-medium text-gray-900 truncate">
                      {ticket.title}
                    </h3>
                  </div>

                  <div className="flex justify-between items-center">
                    <span className={`
                      text-sm font-medium px-2 py-0.5 rounded-full
                      ${ticket.priority === 'high' ? 'bg-red-100 text-red-800' : 
                        ticket.priority === 'medium' ? 'bg-yellow-100 text-yellow-800' : 
                        'bg-blue-100 text-blue-800'}
                    `}>
                      {ticket.priority.charAt(0).toUpperCase() + ticket.priority.slice(1)}
                    </span>
                    <span className="text-xs text-gray-400">
                      {formatMessageDate(ticket.updated_at)}
                    </span>
                  </div>
                </div>
              </div>
            );
          })
        )}
      </div>
    </div>
  );
}
