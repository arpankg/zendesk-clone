import React, { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import { supabase } from '../../config/supabase';
import LoadingSpinner from '../components/common/LoadingSpinner';
import ErrorMessage from '../components/common/ErrorMessage';
import { MessageBubble } from '../components/common/MessageBubble';
import type { Database } from '../../config/types';

// Add logger
const logger = {
  component: (message: string, data?: any) => {
    console.log(`🎯 [TicketDetails] ${message}${data ? '\n' + JSON.stringify(data, null, 2) : ''}`);
  },
  data: (message: string, data?: any) => {
    console.log(`📦 [Data] ${message}${data ? '\n' + JSON.stringify(data, null, 2) : ''}`);
  },
  error: (message: string, error?: any) => {
    console.error(`❌ [Error] ${message}${error ? '\n' + JSON.stringify(error, null, 2) : ''}`);
  },
  event: (message: string, data?: any) => {
    console.log(`🎭 [Event] ${message}${data ? '\n' + JSON.stringify(data, null, 2) : ''}`);
  },
  render: (message: string, data?: any) => {
    console.log(`🎨 [Render] ${message}${data ? '\n' + JSON.stringify(data, null, 2) : ''}`);
  }
};

type Ticket = Database['public']['Tables']['tickets']['Row'];
type MessageEvent = Ticket['ticket_history']['events'][0] & { content: string };

const formatMessageDate = (date: string) => {
  logger.event(`Formatting date: ${date}`);
  const messageDate = new Date(date);
  const today = new Date();
  const yesterday = new Date(today);
  yesterday.setDate(yesterday.getDate() - 1);
  
  const days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
  const time = messageDate.toLocaleTimeString('en-US', { 
    hour: '2-digit', 
    minute: '2-digit', 
    hour12: false 
  });

  let formattedDate: string;
  if (messageDate.toDateString() === today.toDateString()) {
    formattedDate = time;
  } else if (messageDate.toDateString() === yesterday.toDateString()) {
    formattedDate = `Yesterday ${time}`;
  } else {
    formattedDate = `${days[messageDate.getDay()]} ${time}`;
  }
  
  logger.event(`Formatted date result: ${formattedDate}`);
  return formattedDate;
};

const getInitials = (name: string) => {
  logger.event(`Getting initials for: ${name}`);
  const initials = name
    .split(' ')
    .map(part => part[0])
    .join('')
    .toUpperCase();
  logger.event(`Generated initials: ${initials}`);
  return initials;
};

const TicketDetails = () => {
  logger.component('Component mounted');
  const { id } = useParams<{ id: string }>();
  const [ticket, setTicket] = useState<Ticket | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    logger.component(`Effect triggered with ticket ID: ${id}`);
    
    const fetchTicket = async () => {
      try {
        logger.data('Fetching ticket data...');
        const { data, error } = await supabase
          .from('tickets')
          .select('*')
          .eq('id', id)
          .single();

        if (error) {
          logger.error('Failed to fetch ticket', error);
          throw error;
        }
        
        logger.data('Ticket data fetched successfully', data);
        setTicket(data);
      } catch (err) {
        const errorMessage = err instanceof Error ? err.message : 'Failed to fetch ticket';
        logger.error(errorMessage, err);
        setError(errorMessage);
      } finally {
        logger.data('Fetch operation completed');
        setLoading(false);
      }
    };

    if (id) {
      fetchTicket();
    } else {
      logger.error('No ticket ID provided');
    }
  }, [id]);

  if (loading) {
    logger.render('Rendering loading state');
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <LoadingSpinner />
      </div>
    );
  }

  if (error || !ticket) {
    logger.render('Rendering error state', { error });
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <ErrorMessage message={error || 'Ticket not found'} />
      </div>
    );
  }

  const messages = (ticket.ticket_history?.events || [])
    .filter((event): event is MessageEvent => {
      const isMessage = event.type === 'message' && typeof event.content === 'string';
      logger.data(`Filtering message event: ${event.id}, isValid: ${isMessage}`);
      return isMessage;
    })
    .sort((a, b) => {
      const timeA = new Date(a.created_at).getTime();
      const timeB = new Date(b.created_at).getTime();
      logger.data(`Sorting messages: ${new Date(timeA).toISOString()} vs ${new Date(timeB).toISOString()}`);
      return timeA - timeB;
    });

  logger.render('Rendering ticket details', {
    ticketId: ticket.id,
    messageCount: messages.length,
    status: ticket.status,
    priority: ticket.priority
  });

  return (
    <div className="min-h-screen bg-white">
      {/* Header */}
      <div className="border-b border-gray-200">
        <div className="max-w-5xl mx-auto px-4 py-4">
          <div className="flex justify-between items-center">
            <div>
              <h1 className="text-2xl font-semibold text-gray-900">{ticket.title}</h1>
              <p className="text-sm text-gray-500 mt-1">Via {ticket.source_channel}</p>
            </div>
            <div className="flex items-center space-x-4">
              <button 
                className="p-2 text-gray-400 hover:text-gray-600"
                onClick={() => logger.event('Filter button clicked')}
              >
                <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2.586a1 1 0 01-.293.707l-6.414 6.414a1 1 0 00-.293.707V17l-4 4v-6.586a1 1 0 00-.293-.707L3.293 7.293A1 1 0 013 6.586V4z" />
                </svg>
              </button>
              <button 
                className="p-2 text-gray-400 hover:text-gray-600"
                onClick={() => logger.event('Menu button clicked')}
              >
                <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 5v.01M12 12v.01M12 19v.01M12 6a1 1 0 110-2 1 1 0 010 2zm0 7a1 1 0 110-2 1 1 0 010 2zm0 7a1 1 0 110-2 1 1 0 010 2z" />
                </svg>
              </button>
            </div>
          </div>
        </div>
      </div>

      {/* Messages */}
      <div className="max-w-5xl mx-auto px-4 py-6">
        <div className="space-y-6">
          {messages.map((message) => {
            const isCustomer = message.created_by === ticket.customer_email;
            const name = isCustomer ? message.created_by.split('@')[0] : 'Arpan Gupta';
            logger.render(`Rendering message`, {
              messageId: message.id,
              isCustomer,
              name,
              timestamp: message.created_at
            });
            
            return (
              <MessageBubble
                key={message.id}
                isCustomer={isCustomer}
                message={message.content}
                timestamp={formatMessageDate(message.created_at)}
                username={name}
                channel={ticket.source_channel}
              />
            );
          })}
          {messages.length === 0 && (
            <div className="text-center text-gray-500 py-8">
              No messages in this ticket yet.
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

export default TicketDetails;
