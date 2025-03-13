import React, { useState } from 'react';
import { Dialog, DialogContent, DialogTrigger } from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { X, ChevronLeft, ChevronRight, Maximize2 } from 'lucide-react';
import { cn } from '@/lib/utils';

interface ImageGalleryProps {
  images: string[];
  className?: string;
  aspectRatio?: 'square' | 'video' | 'wide';
}

export function ImageGallery({
  images,
  className,
  aspectRatio = 'square',
}: ImageGalleryProps) {
  const [currentIndex, setCurrentIndex] = useState(0);
  const [isOpen, setIsOpen] = useState(false);

  const handlePrevious = (e: React.MouseEvent) => {
    e.stopPropagation();
    setCurrentIndex((prev) => (prev === 0 ? images.length - 1 : prev - 1));
  };

  const handleNext = (e: React.MouseEvent) => {
    e.stopPropagation();
    setCurrentIndex((prev) => (prev === images.length - 1 ? 0 : prev + 1));
  };

  const handleKeyDown = (e: React.KeyboardEvent) => {
    if (e.key === 'ArrowLeft') {
      setCurrentIndex((prev) => (prev === 0 ? images.length - 1 : prev - 1));
    } else if (e.key === 'ArrowRight') {
      setCurrentIndex((prev) => (prev === images.length - 1 ? 0 : prev + 1));
    } else if (e.key === 'Escape') {
      setIsOpen(false);
    }
  };

  const aspectRatioClass = {
    square: 'aspect-square',
    video: 'aspect-video',
    wide: 'aspect-[16/9]',
  }[aspectRatio];

  if (images.length === 0) {
    return (
      <div className={cn('bg-muted rounded-md flex items-center justify-center', aspectRatioClass, className)}>
        <p className="text-muted-foreground">Nenhuma imagem disponível</p>
      </div>
    );
  }

  if (images.length === 1) {
    return (
      <Dialog open={isOpen} onOpenChange={setIsOpen}>
        <DialogTrigger asChild>
          <div className={cn('relative group cursor-pointer rounded-md overflow-hidden', aspectRatioClass, className)}>
            <img
              src={images[0]}
              alt="Imagem"
              className="w-full h-full object-cover transition-transform group-hover:scale-105"
            />
            <div className="absolute inset-0 bg-black/40 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center">
              <Maximize2 className="text-white h-8 w-8" />
            </div>
          </div>
        </DialogTrigger>
        <DialogContent className="max-w-4xl p-0 bg-transparent border-none">
          <div className="relative">
            <img
              src={images[0]}
              alt="Imagem em tela cheia"
              className="w-full h-auto max-h-[80vh] object-contain"
            />
            <Button
              variant="ghost"
              size="icon"
              className="absolute top-2 right-2 bg-black/60 hover:bg-black/80 text-white"
              onClick={() => setIsOpen(false)}
            >
              <X className="h-4 w-4" />
            </Button>
          </div>
        </DialogContent>
      </Dialog>
    );
  }

  return (
    <div className={cn('space-y-2', className)}>
      <Dialog open={isOpen} onOpenChange={setIsOpen}>
        <DialogTrigger asChild>
          <div 
            className={cn('relative group cursor-pointer rounded-md overflow-hidden', aspectRatioClass)}
            tabIndex={0}
            onKeyDown={(e) => {
              if (e.key === 'Enter') setIsOpen(true);
            }}
            aria-label="Abrir galeria de imagens"
          >
            <img
              src={images[currentIndex]}
              alt={`Imagem ${currentIndex + 1} de ${images.length}`}
              className="w-full h-full object-cover transition-transform group-hover:scale-105"
            />
            <div className="absolute inset-0 bg-black/40 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center">
              <Maximize2 className="text-white h-8 w-8" />
            </div>
            
            <Button
              variant="ghost"
              size="icon"
              className="absolute top-1/2 left-2 -translate-y-1/2 bg-black/60 hover:bg-black/80 text-white opacity-0 group-hover:opacity-100 transition-opacity"
              onClick={handlePrevious}
              aria-label="Imagem anterior"
            >
              <ChevronLeft className="h-4 w-4" />
            </Button>
            
            <Button
              variant="ghost"
              size="icon"
              className="absolute top-1/2 right-2 -translate-y-1/2 bg-black/60 hover:bg-black/80 text-white opacity-0 group-hover:opacity-100 transition-opacity"
              onClick={handleNext}
              aria-label="Próxima imagem"
            >
              <ChevronRight className="h-4 w-4" />
            </Button>
            
            <div className="absolute bottom-2 left-0 right-0 flex justify-center gap-1">
              {images.map((_, index) => (
                <div
                  key={index}
                  className={cn(
                    'h-1.5 w-1.5 rounded-full bg-white/70',
                    index === currentIndex && 'bg-white w-3'
                  )}
                />
              ))}
            </div>
          </div>
        </DialogTrigger>
        
        <DialogContent 
          className="max-w-4xl p-0 bg-transparent border-none"
          onKeyDown={handleKeyDown}
        >
          <div className="relative">
            <img
              src={images[currentIndex]}
              alt={`Imagem ${currentIndex + 1} de ${images.length}`}
              className="w-full h-auto max-h-[80vh] object-contain"
            />
            
            <Button
              variant="ghost"
              size="icon"
              className="absolute top-2 right-2 bg-black/60 hover:bg-black/80 text-white"
              onClick={() => setIsOpen(false)}
              aria-label="Fechar galeria"
            >
              <X className="h-4 w-4" />
            </Button>
            
            <Button
              variant="ghost"
              size="icon"
              className="absolute top-1/2 left-4 -translate-y-1/2 bg-black/60 hover:bg-black/80 text-white"
              onClick={handlePrevious}
              aria-label="Imagem anterior"
            >
              <ChevronLeft className="h-6 w-6" />
            </Button>
            
            <Button
              variant="ghost"
              size="icon"
              className="absolute top-1/2 right-4 -translate-y-1/2 bg-black/60 hover:bg-black/80 text-white"
              onClick={handleNext}
              aria-label="Próxima imagem"
            >
              <ChevronRight className="h-6 w-6" />
            </Button>
            
            <div className="absolute bottom-4 left-0 right-0 flex justify-center gap-1">
              {images.map((_, index) => (
                <div
                  key={index}
                  className={cn(
                    'h-2 w-2 rounded-full bg-white/70 cursor-pointer',
                    index === currentIndex && 'bg-white w-4'
                  )}
                  onClick={() => setCurrentIndex(index)}
                />
              ))}
            </div>
          </div>
        </DialogContent>
      </Dialog>
      
      <div className="grid grid-cols-4 gap-2">
        {images.slice(0, 4).map((image, index) => (
          <div
            key={index}
            className={cn(
              'aspect-square rounded-md overflow-hidden cursor-pointer',
              currentIndex === index && 'ring-2 ring-primary'
            )}
            onClick={() => {
              setCurrentIndex(index);
              setIsOpen(true);
            }}
          >
            <img
              src={image}
              alt={`Miniatura ${index + 1}`}
              className="w-full h-full object-cover"
            />
          </div>
        ))}
      </div>
    </div>
  );
} 