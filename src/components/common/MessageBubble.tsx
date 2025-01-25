import { cn } from "@/lib/utils"

interface MessageBubbleProps {
  isCustomer: boolean
  message: string
  timestamp: string
  username: string
  channel: string
}

export function MessageBubble({
  isCustomer,
  message,
  timestamp,
  username,
  channel,
}: MessageBubbleProps) {
  return (
    <div
      className={cn(
        "flex flex-col max-w-[50%] space-y-1",
        isCustomer ? "items-end ml-auto" : "items-start"
      )}
    >
      <span className="text-sm text-muted-foreground">{username}</span>
      <div
        className={cn(
          "rounded-lg px-3 py-2",
          isCustomer
            ? "bg-blue-500 text-white"
            : "bg-gray-100 text-gray-900"
        )}
      >
        <p className="text-sm">{message}</p>
      </div>
      <div className="flex items-center space-x-2 text-xs text-muted-foreground">
        <span>{timestamp}</span>
        <span>•</span>
        <span>via {channel}</span>
      </div>
    </div>
  )
}
