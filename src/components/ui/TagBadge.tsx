
import React from 'react';
import { cn } from '@/lib/utils';

interface TagBadgeProps {
  children: React.ReactNode;
  variant?: 'default' | 'outline';
  className?: string;
  onClick?: () => void;
}

const TagBadge: React.FC<TagBadgeProps> = ({
  children,
  variant = 'default',
  className,
  onClick,
}) => {
  const baseStyles = "inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-medium transition-colors";
  
  const variantStyles = {
    default: "bg-recife-primary text-white hover:bg-recife-primary-hover",
    outline: "bg-transparent border border-gray-300 text-recife-dark hover:bg-gray-100",
  };
  
  return (
    <span 
      className={cn(
        baseStyles, 
        variantStyles[variant],
        onClick ? "cursor-pointer" : "",
        className
      )}
      onClick={onClick}
    >
      {children}
    </span>
  );
};

export default TagBadge;
