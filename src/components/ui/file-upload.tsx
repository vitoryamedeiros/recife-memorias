import React, { useState, useRef } from 'react';
import { Button } from '@/components/ui/button';
import { Progress } from '@/components/ui/progress';
import { useStorage } from '@/hooks/use-storage';
import { Upload, X, Image, FileText, File } from 'lucide-react';

interface FileUploadProps {
  onUploadComplete: (url: string) => void;
  bucket: string;
  folder?: string;
  fileTypes?: string[];
  maxSizeMB?: number;
  className?: string;
  variant?: 'default' | 'outline' | 'secondary' | 'ghost' | 'link' | 'destructive';
  label?: string;
}

export function FileUpload({
  onUploadComplete,
  bucket,
  folder,
  fileTypes = ['.jpg', '.jpeg', '.png', '.gif', '.webp'],
  maxSizeMB = 5,
  className = '',
  variant = 'outline',
  label = 'Enviar arquivo',
}: FileUploadProps) {
  const [preview, setPreview] = useState<string | null>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);
  const { uploadFile, isUploading, progress } = useStorage();

  const handleFileChange = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;

    // Criar preview para imagens
    if (file.type.startsWith('image/')) {
      const reader = new FileReader();
      reader.onload = () => {
        setPreview(reader.result as string);
      };
      reader.readAsDataURL(file);
    }

    // Fazer upload do arquivo
    const url = await uploadFile(file, {
      bucket,
      folder,
      fileTypes,
      maxSizeMB,
    });

    if (url) {
      onUploadComplete(url);
    }
  };

  const handleButtonClick = () => {
    fileInputRef.current?.click();
  };

  const handleRemovePreview = () => {
    setPreview(null);
    if (fileInputRef.current) {
      fileInputRef.current.value = '';
    }
  };

  const getFileIcon = (fileType: string) => {
    if (fileType.startsWith('image/')) return <Image className="h-6 w-6" />;
    if (fileType.startsWith('text/')) return <FileText className="h-6 w-6" />;
    return <File className="h-6 w-6" />;
  };

  return (
    <div className={`w-full ${className}`}>
      <input
        type="file"
        ref={fileInputRef}
        onChange={handleFileChange}
        accept={fileTypes.join(',')}
        className="hidden"
      />

      {!preview && !isUploading && (
        <Button
          type="button"
          variant={variant}
          onClick={handleButtonClick}
          className="w-full h-32 flex flex-col items-center justify-center gap-2 border-dashed"
          disabled={isUploading}
        >
          <Upload className="h-6 w-6" />
          <span>{label}</span>
          <span className="text-xs text-muted-foreground">
            {fileTypes.join(', ')} (máx. {maxSizeMB}MB)
          </span>
        </Button>
      )}

      {isUploading && (
        <div className="w-full p-4 border rounded-md">
          <div className="flex items-center justify-between mb-2">
            <span className="text-sm font-medium">Enviando arquivo...</span>
            <span className="text-xs text-muted-foreground">{progress}%</span>
          </div>
          <Progress value={progress} className="h-2" />
        </div>
      )}

      {preview && !isUploading && (
        <div className="relative w-full h-32 border rounded-md overflow-hidden">
          <img
            src={preview}
            alt="Preview"
            className="w-full h-full object-cover"
          />
          <Button
            type="button"
            variant="destructive"
            size="icon"
            className="absolute top-2 right-2 h-6 w-6"
            onClick={handleRemovePreview}
          >
            <X className="h-4 w-4" />
          </Button>
        </div>
      )}
    </div>
  );
} 