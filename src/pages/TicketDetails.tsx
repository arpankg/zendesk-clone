import React from 'react';
import { useParams } from 'react-router-dom';

const TicketDetails = () => {
  const { id } = useParams<{ id: string }>();

  return (
    <div className="min-h-screen bg-gray-50 flex items-center justify-center">
      <h1 className="text-2xl font-bold">Hello World - Ticket {id}</h1>
    </div>
  );
};

export default TicketDetails;
