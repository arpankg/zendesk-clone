import { clsx, type ClassValue } from "clsx"
import { twMerge } from "tailwind-merge"

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}

export function formatMessageDate(date: string) {
  const messageDate = new Date(date);
  const today = new Date();
  const yesterday = new Date(today);
  yesterday.setDate(yesterday.getDate() - 1);
  
  const time = messageDate.toLocaleTimeString('en-US', { 
    hour: 'numeric', 
    minute: '2-digit'
  });
  
  const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  
  let formattedDate = time;
  
  if (messageDate.toDateString() === today.toDateString()) {
    formattedDate = time;
  } else if (messageDate.toDateString() === yesterday.toDateString()) {
    formattedDate = `Yesterday ${time}`;
  } else {
    formattedDate = `${days[messageDate.getDay()]} ${time}`;
  }
  
  return formattedDate;
}
