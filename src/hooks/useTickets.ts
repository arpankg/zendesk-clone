import { useEffect, useState } from 'react';
import { supabase } from '../../config/supabase';
import { Database } from '../../config/types';

type Ticket = Database['public']['Tables']['tickets']['Row'];

export function useTickets() {
  const [tickets, setTickets] = useState<Ticket[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  useEffect(() => {
    async function fetchTickets() {
      try {
        console.log('🎯 Fetching initial tickets...');
        const { data, error } = await supabase
          .from('tickets')
          .select(`
            *,
            customers (
              first_name,
              last_name
            )
          `)
          .order('created_at', { ascending: false });

        if (error) {
          throw error;
        }

        if (data) {
          const formattedTickets = data.map(ticket => ({
            ...ticket,
            customer_first_name: ticket.customers?.first_name,
            customer_last_name: ticket.customers?.last_name,
          }));

          console.log('✅ Successfully fetched tickets:', formattedTickets.length);
          setTickets(formattedTickets);
        }
      } catch (err) {
        console.error('❌ Error fetching tickets:', err);
        setError(err as Error);
      } finally {
        setLoading(false);
      }
    }

    // Initial fetch
    fetchTickets();

    // Set up real-time subscription
    console.log('🔄 Setting up real-time subscription...');
    const subscription = supabase
      .channel('tickets-changes')
      .on(
        'postgres_changes',
        {
          event: '*',
          schema: 'public',
          table: 'tickets'
        },
        (payload) => {
          console.log('📨 Received ticket change:', {
            event: payload.eventType,
            ticket: payload.new,
            old: payload.old
          });

          // Handle different types of changes
          switch (payload.eventType) {
            case 'INSERT':
              console.log('➕ New ticket inserted:', payload.new.id);
              setTickets(current => [payload.new, ...current]);
              break;

            case 'UPDATE':
              console.log('📝 Ticket updated:', payload.new.id);
              setTickets(current => {
                const index = current.findIndex(t => t.id === payload.new.id);
                if (index === -1) {
                  console.log('⚠️ Updated ticket not found in current list:', payload.new.id);
                  return current;
                }

                const updated = [...current];
                updated[index] = {
                  ...updated[index],
                  ...payload.new,
                };
                return updated;
              });
              break;

            case 'DELETE':
              console.log('🗑️ Ticket deleted:', payload.old.id);
              setTickets(current => 
                current.filter(t => t.id !== payload.old.id)
              );
              break;
          }
        }
      )
      .subscribe((status) => {
        console.log('📡 Subscription status:', status);
      });

    // Cleanup subscription on unmount
    return () => {
      console.log('👋 Cleaning up subscription...');
      subscription.unsubscribe();
    };
  }, []);

  return { tickets, loading, error };
}
