import { useEffect, useState } from 'react';
import { supabase } from '../../config/supabase';

export interface Ticket {
  id: string;
  title: string;
  status: string;
  priority: string;
  source_channel: string;
  created_at: string;
  updated_at: string;
  created_by: string;
  customer_email: string;
  customer_first_name: string;
  customer_last_name: string;
  last_message?: string;
}

export function useTickets() {
  const [tickets, setTickets] = useState<Ticket[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  useEffect(() => {
    async function fetchTickets() {
      try {
        const { data, error } = await supabase
          .from('tickets')
          .select(`
            *,
            customers (
              first_name,
              last_name
            )
          `)
          .order('updated_at', { ascending: false });

        if (error) {
          throw error;
        }

        if (data) {
          const formattedTickets = data.map(ticket => ({
            ...ticket,
            customer_first_name: ticket.customers?.first_name,
            customer_last_name: ticket.customers?.last_name,
          }));

          setTickets(formattedTickets);
        }
      } catch (err) {
        setError(err as Error);
      } finally {
        setLoading(false);
      }
    }

    fetchTickets();
  }, []);

  return { tickets, loading, error };
}
