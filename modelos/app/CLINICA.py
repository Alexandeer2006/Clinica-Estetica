import tkinter as tk
from tkinter import messagebox, simpledialog
import mysql.connector
from mysql.connector import Error

# ==========================
# 1. CONEXIÓN BASE DE DATOS
# ==========================
def conectar_bd():
    try:
        return mysql.connector.connect(
            host='localhost',
            user='root',
            password='Zuleyka#2006',  # Tu contraseña
            database='clinica'
        )
    except Error as e:
        messagebox.showerror("Error de Conexión", str(e))
        return None

# ==========================
# 2. FUNCIONES AUXILIARES
# ==========================
def mostrar_resultados(titulo, resultados):
    if not resultados:
        messagebox.showinfo(titulo, "No hay registros")
        return
    texto = ""
    for r in resultados:
        texto += "\n".join(f"{k}: {v}" for k, v in r.items())
        texto += "\n" + "-" * 50 + "\n"
    
    # Creamos una ventana con scroll si el texto es muy largo
    v_res = tk.Toplevel()
    v_res.title(titulo)
    v_res.geometry("400x400")
    text_area = tk.Text(v_res, wrap="word")
    text_area.insert("1.0", texto)
    text_area.pack(expand=True, fill="both")
    tk.Button(v_res, text="Cerrar", command=v_res.destroy).pack()

# ==========================
# 3. MÓDULO PACIENTES
# ==========================
def agregar_paciente():
    con = conectar_bd()
    if con:
        cur = con.cursor()
        datos = (
            simpledialog.askstring("Paciente", "Nombre:"),
            simpledialog.askstring("Paciente", "Apellido:"),
            simpledialog.askstring("Paciente", "Fecha nacimiento (YYYY-MM-DD):"),
            simpledialog.askstring("Paciente", "Teléfono:"),
            simpledialog.askstring("Paciente", "Dirección:"),
            simpledialog.askstring("Paciente", "Correo:")
        )
        if all(datos):
            try:
                cur.execute("""
                    INSERT INTO pacientes 
                    (nombre_paciente, apellido_paciente, fecha_nacimiento, telefono, direccion, correo) 
                    VALUES (%s,%s,%s,%s,%s,%s)
                """, datos)
                con.commit()
                messagebox.showinfo("OK", "Paciente agregado")
            except Error as e:
                messagebox.showerror("Error", str(e))
        con.close()

def consultar_paciente():
    con = conectar_bd()
    if con:
        nombre = simpledialog.askstring("Consultar", "Nombre o Apellido:")
        if nombre:
            cur = con.cursor(dictionary=True)
            query = "SELECT * FROM pacientes WHERE nombre_paciente LIKE %s OR apellido_paciente LIKE %s"
            cur.execute(query, (f"%{nombre}%", f"%{nombre}%"))
            mostrar_resultados("Resultados Pacientes", cur.fetchall())
        con.close()

def listar_pacientes():
    con = conectar_bd()
    if con:
        cur = con.cursor(dictionary=True)
        cur.execute("SELECT * FROM pacientes")
        mostrar_resultados("Lista de Pacientes", cur.fetchall())
        con.close()

def editar_paciente():
    con = conectar_bd()
    if con:
        idp = simpledialog.askinteger("Editar", "ID Paciente:")
        if idp:
            col = simpledialog.askstring("Editar", "Columna (fecha_nacimiento, nombre_paciente, apellido_paciente, telefono, direccion, correo):")
            val = simpledialog.askstring("Editar", "Nuevo Valor:")
            if col and val:
                try:
                    cur = con.cursor()
                    cur.execute(f"UPDATE pacientes SET {col}=%s WHERE id_paciente=%s", (val, idp))
                    con.commit()
                    messagebox.showinfo("OK", "Paciente actualizado")
                except Error as e:
                    messagebox.showerror("Error", str(e))
        con.close()

def eliminar_paciente():
    con = conectar_bd()
    if con:
        idp = simpledialog.askinteger("Eliminar", "ID Paciente:")
        if idp:
            try:
                cur = con.cursor()
                cur.execute("DELETE FROM pacientes WHERE id_paciente=%s", (idp,))
                con.commit()
                messagebox.showinfo("OK", "Paciente eliminado")
            except Error as e:
                messagebox.showerror("Error", str(e))
        con.close()

# ==========================
# 4. MÓDULO CITAS
# ==========================
def agregar_cita():
    con = conectar_bd()
    if con:
        cur = con.cursor()
        datos = (
            simpledialog.askstring("Cita", "Fecha (YYYY-MM-DD):"),
            simpledialog.askstring("Cita", "Hora (HH:MM:SS):"),
            simpledialog.askstring("Cita", "Estado (Pendiente/Confirmada/Atendida/Cancelada):"),
            simpledialog.askstring("Cita", "Observación:"),
            simpledialog.askinteger("Cita", "ID Paciente:")
        )
        if all(x is not None for x in datos):
            try:
                cur.execute("INSERT INTO citas (fecha_cita, hora_cita, estado_cita, observacion, id_paciente) VALUES (%s,%s,%s,%s,%s)", datos)
                con.commit()
                messagebox.showinfo("OK", "Cita registrada")
            except Error as e:
                messagebox.showerror("Error", str(e))
        con.close()

def listar_citas():
    con = conectar_bd()
    if con:
        cur = con.cursor(dictionary=True)
        cur.execute("SELECT * FROM citas")
        mostrar_resultados("Citas", cur.fetchall())
        con.close()

def editar_cita():
    con = conectar_bd()
    if con:
        idc = simpledialog.askinteger("Editar", "ID Cita:")
        if idc:
            col = simpledialog.askstring("Editar", "Campo (fecha_cita, hora_cita, estado_cita, observacion, id_paciente):")
            val = simpledialog.askstring("Editar", "Nuevo Valor:")
            if col and val:
                try:
                    cur = con.cursor()
                    cur.execute(f"UPDATE citas SET {col}=%s WHERE id_cita=%s", (val, idc))
                    con.commit()
                    messagebox.showinfo("OK", "Cita actualizada")
                except Error as e:
                    messagebox.showerror("Error", str(e))
        con.close()

def eliminar_cita():
    con = conectar_bd()
    if con:
        idc = simpledialog.askinteger("Eliminar", "ID Cita:")
        if idc:
            try:
                cur = con.cursor()
                cur.execute("DELETE FROM citas WHERE id_cita=%s", (idc,))
                con.commit()
                messagebox.showinfo("OK", "Cita eliminada")
            except Error as e:
                messagebox.showerror("Error", str(e))
        con.close()

# ==========================
# 5. MÓDULO FACTURAS
# ==========================
def agregar_factura():
    con = conectar_bd()
    if con:
        cur = con.cursor()
        datos = (
            simpledialog.askstring("Factura", "Fecha (YYYY-MM-DD):"),
            simpledialog.askinteger("Factura", "Descuento:"),
            simpledialog.askstring("Factura", "Método Pago:"),
            simpledialog.askfloat("Factura", "Subtotal:"),
            simpledialog.askstring("Factura", "Estado Pago:"),
            simpledialog.askinteger("Factura", "ID Recepcionista:"),
            simpledialog.askinteger("Factura", "ID Paciente:")
        )
        if all(x is not None for x in datos):
            try:
                cur.execute("""INSERT INTO facturas (fecha, descuento, metodo_pago, subtotal, estado_pago, id_recepcionista, id_paciente) 
                               VALUES (%s,%s,%s,%s,%s,%s,%s)""", datos)
                con.commit()
                messagebox.showinfo("OK", "Factura creada")
            except Error as e:
                messagebox.showerror("Error", str(e))
        con.close()

def consultar_encargado_pago():
    con = conectar_bd()
    if con:
        idf = simpledialog.askinteger("Encargado", "ID Factura:")
        if idf:
            cur = con.cursor(dictionary=True)
            query = """SELECT f.id_factura, r.nombre_recepcionista 
                       FROM facturas f 
                       JOIN recepcionista r ON f.id_recepcionista = r.id_recepcionista 
                       WHERE f.id_factura = %s"""
            cur.execute(query, (idf,))
            res = cur.fetchall()
            mostrar_resultados("Encargado del cobro", res)
        con.close()

def listar_facturas():
    con = conectar_bd()
    if con:
        cur = con.cursor(dictionary=True)
        cur.execute("SELECT * FROM facturas")
        mostrar_resultados("Facturas", cur.fetchall())
        con.close()

def editar_factura():
    con = conectar_bd()
    if con:
        idf = simpledialog.askinteger("Editar", "ID Factura:")
        if idf:
            col = simpledialog.askstring("Editar", "Campo (fecha, descuento, estado_pago, metodo_pago, subtotal, id_recepcionista, id_paciente):")
            val = simpledialog.askstring("Editar", "Nuevo Valor:")
            if col and val:
                try:
                    cur = con.cursor()
                    cur.execute(f"UPDATE facturas SET {col}=%s WHERE id_factura=%s", (val, idf))
                    con.commit()
                    messagebox.showinfo("OK", "Factura actualizada")
                except Error as e:
                    messagebox.showerror("Error", str(e))
        con.close()

def eliminar_factura():
    con = conectar_bd()
    if con:
        idf = simpledialog.askinteger("Eliminar", "ID Factura:")
        if idf:
            try:
                cur = con.cursor()
                cur.execute("DELETE FROM facturas WHERE id_factura=%s", (idf,))
                con.commit()
                messagebox.showinfo("OK", "Factura eliminada")
            except Error as e:
                messagebox.showerror("Error", str(e))
        con.close()

# ==========================
# 6. MÓDULO INVENTARIO (PRODUCTOS)
# ==========================
def agregar_producto():
    con = conectar_bd()
    if con:
        cur = con.cursor()
        # Pedimos ID porque en SQL no es AutoIncrement
        datos = (
            simpledialog.askinteger("Producto", "ID Producto:"),
            simpledialog.askstring("Producto", "Nombre:"),
            simpledialog.askinteger("Producto", "Precio:"),
            simpledialog.askstring("Producto", "Marca:"),
            simpledialog.askstring("Producto", "Categoría:"),
            simpledialog.askinteger("Producto", "Stock:"),
            simpledialog.askstring("Producto", "Expiración (YYYY-MM-DD):"),
            simpledialog.askstring("Producto", "Elaboración (YYYY-MM-DD):"),
            simpledialog.askinteger("Producto", "ID Enfermera Encargada:")
        )
        if all(x is not None for x in datos):
            try:
                cur.execute("""INSERT INTO productos 
                (id_producto, nombre_producto, precio_unitario, marca, categoria, disponibilidad, expiracion, elaboracion, id_enfermera)
                VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)""", datos)
                con.commit()
                messagebox.showinfo("OK", "Producto agregado")
            except Error as e:
                messagebox.showerror("Error", str(e))
        con.close()

def listar_productos():
    con = conectar_bd()
    if con:
        cur = con.cursor(dictionary=True)
        cur.execute("SELECT * FROM productos")
        mostrar_resultados("Inventario", cur.fetchall())
        con.close()

def consultar_encargado_revision():
    con = conectar_bd()
    if con:
        prod = simpledialog.askstring("Revisión", "Nombre Producto:")
        if prod:
            cur = con.cursor(dictionary=True)
            query = """SELECT p.nombre_producto, e.nombre_enfermera, e.apellido_enfermera 
                       FROM productos p JOIN enfermeras e ON p.id_enfermera = e.id_enfermera 
                       WHERE p.nombre_producto LIKE %s"""
            cur.execute(query, (f"%{prod}%",))
            mostrar_resultados("Enfermera Encargada", cur.fetchall())
        con.close()

def editar_producto():
    con = conectar_bd()
    if con:
        idp = simpledialog.askinteger("Editar", "ID Producto:")
        if idp:
            col = simpledialog.askstring("Editar", "Campo (disponibilidad, precio_unitario, marca):")
            val = simpledialog.askstring("Editar", "Nuevo Valor:")
            if col and val:
                try:
                    cur = con.cursor()
                    cur.execute(f"UPDATE productos SET {col}=%s WHERE id_producto=%s", (val, idp))
                    con.commit()
                    messagebox.showinfo("OK", "Producto actualizado")
                except Error as e:
                    messagebox.showerror("Error", str(e))
        con.close()

def eliminar_producto():
    con = conectar_bd()
    if con:
        idp = simpledialog.askinteger("Eliminar", "ID Producto:")
        if idp:
            try:
                cur = con.cursor()
                cur.execute("DELETE FROM productos WHERE id_producto=%s", (idp,))
                con.commit()
                messagebox.showinfo("OK", "Producto eliminado")
            except Error as e:
                messagebox.showerror("Error", str(e))
        con.close()

# ==========================
# 7. MÓDULO PROFESIONALES
# ==========================
def agregar_profesional():
    con = conectar_bd()
    if con:
        try:
            cur = con.cursor()
            id_prof = simpledialog.askinteger("Profesional", "ID Profesional:")
            nombre = simpledialog.askstring("Profesional", "Nombre:")
            apellido = simpledialog.askstring("Profesional", "Apellido:")
            fecha = simpledialog.askstring("Profesional", "Fecha Nac (YYYY-MM-DD):")
            correo = simpledialog.askstring("Profesional", "Correo:")
            tel = simpledialog.askstring("Profesional", "Teléfono:")
            salario = simpledialog.askfloat("Profesional", "Salario:")
            tipo = simpledialog.askstring("Profesional", "Tipo (doctor/cosmetologo):").lower()

            if id_prof and nombre and tipo in ['doctor', 'cosmetologo']:

                sql_padre = """INSERT INTO profesionales 
                               (id_profesional, nombre_prof, apellido_prof, fecha_nacimiento, 
                                correo_profesional, telefono, salario, tipo_prof) 
                               VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"""

                cur.execute(sql_padre, (id_prof, nombre, apellido, fecha, correo, tel, salario, tipo))


                con.commit()
                messagebox.showinfo("OK",
                                    f"Profesional ({tipo}) registrado exitosamente.\n(Tablas sincronizadas por Trigger)")
            else:
                messagebox.showwarning("Error", "Datos incompletos o tipo incorrecto")
        except Error as e:
            con.rollback()
            messagebox.showerror("Error BD", str(e))
        finally:
            con.close()

def listar_profesionales():
    con = conectar_bd()
    if con:
        cur = con.cursor(dictionary=True)
        cur.execute("SELECT * FROM profesionales")
        mostrar_resultados("Profesionales", cur.fetchall())
        con.close()


def editar_profesional():
    con = conectar_bd()
    if con:
        idp = simpledialog.askinteger("Editar", "ID Profesional:")
        if idp:
            col = simpledialog.askstring("Editar", "Campo (nombre_prof, apellido_prof, fecha_nacimiento, correo_profesional, telefono, salario, tipo_prof):")
            val = simpledialog.askstring("Editar", "Nuevo Valor:")
            if col and val:
                try:
                    cur = con.cursor()

                    cur.execute(f"UPDATE profesionales SET {col}=%s WHERE id_profesional=%s", (val, idp))
                    con.commit()
                    messagebox.showinfo("OK", "Datos actualizados en todo el sistema")
                except Error as e:
                    messagebox.showerror("Error", str(e))
        con.close()

def eliminar_profesional():
    con = conectar_bd()
    if con:
        idp = simpledialog.askinteger("Eliminar", "ID Profesional:")
        if idp:
            try:
                cur = con.cursor()
                # Primero borramos del hijo, luego del padre (aunque FK Cascade lo haría, mejor ser explícito)
                # Intento genérico:
                cur.execute("DELETE FROM doctor WHERE id_doctor=%s", (idp,))
                cur.execute("DELETE FROM cosmetologo WHERE id_cosmetologo=%s", (idp,))
                cur.execute("DELETE FROM profesionales WHERE id_profesional=%s", (idp,))
                con.commit()
                messagebox.showinfo("OK", "Profesional eliminado")
            except Error as e:
                con.rollback()
                messagebox.showerror("Error", str(e))
        con.close()

# ==========================
# 8. MÓDULO TRATAMIENTOS (CORREGIDO HERENCIA)
# ==========================
def agregar_tratamiento():
    con = conectar_bd()
    if con:
        try:
            cur = con.cursor()
            costo = simpledialog.askfloat("Tratamiento", "Costo:")
            nombre = simpledialog.askstring("Tratamiento", "Nombre:")
            # Respetar mayúsculas exactas del ENUM en SQL: 'Quirurgico', 'No quirurgico'
            tipo = simpledialog.askstring("Tratamiento", "Tipo (Quirurgico / No quirurgico):")
            id_esp = simpledialog.askinteger("Tratamiento", "ID Especialidad:")

            if costo and nombre and tipo and id_esp:
                # 1. Insertar en Padre (tratamientos es AutoIncrement)
                sql_padre = """INSERT INTO tratamientos (costo, nombre_tratamiento, tipo_tratamiento, especialidad) 
                               VALUES (%s,%s,%s,%s)"""
                cur.execute(sql_padre, (costo, nombre, tipo, id_esp))
                
                # Obtener el ID generado
                id_gen = cur.lastrowid

                # 2. Insertar en Hijo
                if tipo.lower() == "quirurgico":
                    det = simpledialog.askstring("Detalle", "Tipo (Alta/Media/Baja):")
                    cur.execute("INSERT INTO quirurgico (id_quirurgico, tipo_quirurgico) VALUES (%s, %s)", (id_gen, det))
                elif "no" in tipo.lower(): # Captura 'No quirurgico'
                    det = simpledialog.askstring("Detalle", "Tipo:")
                    cur.execute("INSERT INTO no_quirurgico (id_no_quirurgico, tipo_no_quirurgico) VALUES (%s, %s)", (id_gen, det))

                con.commit()
                messagebox.showinfo("OK", f"Tratamiento registrado con ID: {id_gen}")
            else:
                messagebox.showwarning("Error", "Datos incompletos")
        except Error as e:
            con.rollback()
            messagebox.showerror("Error BD", str(e))
        finally:
            con.close()

def listar_tratamientos():
    con = conectar_bd()
    if con:
        cur = con.cursor(dictionary=True)
        cur.execute("SELECT * FROM tratamientos")
        mostrar_resultados("Tratamientos", cur.fetchall())
        con.close()

def editar_tratamiento():
    con = conectar_bd()
    if con:
        idt = simpledialog.askinteger("Editar", "ID Tratamiento:")
        if idt:
            col = simpledialog.askstring("Editar", "Campo (costo, nombre_tratamiento):")
            val = simpledialog.askstring("Editar", "Nuevo Valor:")
            if col and val:
                try:
                    cur = con.cursor()
                    cur.execute(f"UPDATE tratamientos SET {col}=%s WHERE id_tratamiento=%s", (val, idt))
                    con.commit()
                    messagebox.showinfo("OK", "Tratamiento actualizado")
                except Error as e:
                    messagebox.showerror("Error", str(e))
        con.close()

def eliminar_tratamiento():
    con = conectar_bd()
    if con:
        idt = simpledialog.askinteger("Eliminar", "ID Tratamiento:")
        if idt:
            try:
                cur = con.cursor()
                cur.execute("DELETE FROM quirurgico WHERE id_quirurgico=%s", (idt,))
                cur.execute("DELETE FROM no_quirurgico WHERE id_no_quirurgico=%s", (idt,))
                cur.execute("DELETE FROM tratamientos WHERE id_tratamiento=%s", (idt,))
                con.commit()
                messagebox.showinfo("OK", "Tratamiento eliminado")
            except Error as e:
                con.rollback()
                messagebox.showerror("Error", str(e))
        con.close()

# ==========================
# 9. MÓDULO ENFERMERAS (NUEVO)
# ==========================
def agregar_enfermera():
    con = conectar_bd()
    if con:
        cur = con.cursor()
        datos = (
            simpledialog.askinteger("Enfermera", "ID Enfermera:"),
            simpledialog.askstring("Enfermera", "Nombre:"),
            simpledialog.askstring("Enfermera", "Apellido:"),
            simpledialog.askstring("Enfermera", "Fecha Nac (YYYY-MM-DD):"),
            simpledialog.askstring("Enfermera", "Correo:"),
            simpledialog.askinteger("Enfermera", "Teléfono:"),
            simpledialog.askfloat("Enfermera", "Salario:")
        )
        if all(x is not None for x in datos):
            try:
                cur.execute("""INSERT INTO enfermeras VALUES (%s,%s,%s,%s,%s,%s,%s)""", datos)
                con.commit()
                messagebox.showinfo("OK", "Enfermera agregada")
            except Error as e:
                messagebox.showerror("Error", str(e))
        con.close()

def listar_enfermeras():
    con = conectar_bd()
    if con:
        cur = con.cursor(dictionary=True)
        cur.execute("SELECT * FROM enfermeras")
        mostrar_resultados("Enfermeras", cur.fetchall())
        con.close()

def editar_enfermera():
    con = conectar_bd()
    if con:
        ide = simpledialog.askinteger("Editar", "ID Enfermera:")
        if ide:
            col = simpledialog.askstring("Editar", "Campo (telefono, correo_enfermera, salario):")
            val = simpledialog.askstring("Editar", "Nuevo Valor:")
            if col and val:
                try:
                    cur = con.cursor()
                    cur.execute(f"UPDATE enfermeras SET {col}=%s WHERE id_enfermera=%s", (val, ide))
                    con.commit()
                    messagebox.showinfo("OK", "Enfermera actualizada")
                except Error as e:
                    messagebox.showerror("Error", str(e))
        con.close()

def eliminar_enfermera():
    con = conectar_bd()
    if con:
        ide = simpledialog.askinteger("Eliminar", "ID Enfermera:")
        if ide:
            try:
                cur = con.cursor()
                cur.execute("DELETE FROM enfermeras WHERE id_enfermera=%s", (ide,))
                con.commit()
                messagebox.showinfo("OK", "Enfermera eliminada")
            except Error as e:
                messagebox.showerror("Error", str(e))
        con.close()

# ==========================
# 10. MÓDULO PROVEEDORES (NUEVO)
# ==========================
def agregar_proveedor():
    con = conectar_bd()
    if con:
        cur = con.cursor()
        datos = (
            simpledialog.askinteger("Proveedor", "ID Proveedor:"),
            simpledialog.askinteger("Proveedor", "Lote:"),
            simpledialog.askstring("Proveedor", "Nombre Proveedor:")
        )
        if all(x is not None for x in datos):
            try:
                cur.execute("INSERT INTO proveedor VALUES (%s,%s,%s)", datos)
                con.commit()
                messagebox.showinfo("OK", "Proveedor agregado")
            except Error as e:
                messagebox.showerror("Error", str(e))
        con.close()

def listar_proveedores():
    con = conectar_bd()
    if con:
        cur = con.cursor(dictionary=True)
        cur.execute("SELECT * FROM proveedor")
        mostrar_resultados("Proveedores", cur.fetchall())
        con.close()

def editar_proveedor():
    con = conectar_bd()
    if con:
        idp = simpledialog.askinteger("Editar", "ID Proveedor:")
        if idp:
            col = simpledialog.askstring("Editar", "Campo (lote, nombre_proveedor):")
            val = simpledialog.askstring("Editar", "Nuevo Valor:")
            if col and val:
                try:
                    cur = con.cursor()
                    cur.execute(f"UPDATE proveedor SET {col}=%s WHERE id_proveedor=%s", (val, idp))
                    con.commit()
                    messagebox.showinfo("OK", "Proveedor actualizado")
                except Error as e:
                    messagebox.showerror("Error", str(e))
        con.close()

def eliminar_proveedor():
    con = conectar_bd()
    if con:
        idp = simpledialog.askinteger("Eliminar", "ID Proveedor:")
        if idp:
            try:
                cur = con.cursor()
                cur.execute("DELETE FROM proveedor WHERE id_proveedor=%s", (idp,))
                con.commit()
                messagebox.showinfo("OK", "Proveedor eliminado")
            except Error as e:
                messagebox.showerror("Error", str(e))
        con.close()

# ==========================
# 11. MENÚS GRÁFICOS
# ==========================
def menu_pacientes():
    v = tk.Toplevel(root)
    v.title("Gestión Pacientes")
    v.geometry("300x300")
    tk.Button(v, text="Agregar Paciente", command=agregar_paciente).pack(fill="x", pady=5)
    tk.Button(v, text="Consultar Paciente", command=consultar_paciente).pack(fill="x", pady=5)
    tk.Button(v, text="Listar Todos", command=listar_pacientes).pack(fill="x", pady=5)
    tk.Button(v, text="Editar Paciente", command=editar_paciente).pack(fill="x", pady=5)
    tk.Button(v, text="Eliminar Paciente", command=eliminar_paciente).pack(fill="x", pady=5)

def menu_citas():
    v = tk.Toplevel(root)
    v.title("Gestión Citas")
    v.geometry("300x300")
    tk.Button(v, text="Agendar Cita", command=agregar_cita).pack(fill="x", pady=5)
    tk.Button(v, text="Ver Citas", command=listar_citas).pack(fill="x", pady=5)
    tk.Button(v, text="Editar Cita", command=editar_cita).pack(fill="x", pady=5)
    tk.Button(v, text="Cancelar/Eliminar Cita", command=eliminar_cita).pack(fill="x", pady=5)

def menu_facturas():
    v = tk.Toplevel(root)
    v.title("Gestión Facturas")
    v.geometry("300x300")
    tk.Button(v, text="Crear Factura", command=agregar_factura).pack(fill="x", pady=5)
    tk.Button(v, text="Ver Encargado Cobro", command=consultar_encargado_pago).pack(fill="x", pady=5)
    tk.Button(v, text="Listar Facturas", command=listar_facturas).pack(fill="x", pady=5)
    tk.Button(v, text="Editar Factura", command=editar_factura).pack(fill="x", pady=5)
    tk.Button(v, text="Eliminar Factura", command=eliminar_factura).pack(fill="x", pady=5)

def menu_inventario():
    v = tk.Toplevel(root)
    v.title("Gestión Inventario")
    v.geometry("300x300")
    tk.Button(v, text="Agregar Producto", command=agregar_producto).pack(fill="x", pady=5)
    tk.Button(v, text="Ver Inventario", command=listar_productos).pack(fill="x", pady=5)
    tk.Button(v, text="Ver Enfermera Encargada", command=consultar_encargado_revision).pack(fill="x", pady=5)
    tk.Button(v, text="Editar Producto", command=editar_producto).pack(fill="x", pady=5)
    tk.Button(v, text="Eliminar Producto", command=eliminar_producto).pack(fill="x", pady=5)

def menu_profesionales():
    v = tk.Toplevel(root)
    v.title("Gestión Profesionales")
    v.geometry("300x300")
    tk.Button(v, text="Registrar Doctor/Cosm.", command=agregar_profesional).pack(fill="x", pady=5)
    tk.Button(v, text="Listar Profesionales", command=listar_profesionales).pack(fill="x", pady=5)
    tk.Button(v, text="Editar Profesional", command=editar_profesional).pack(fill="x", pady=5)
    tk.Button(v, text="Eliminar Profesional", command=eliminar_profesional).pack(fill="x", pady=5)

def menu_tratamientos():
    v = tk.Toplevel(root)
    v.title("Gestión Tratamientos")
    v.geometry("300x300")
    tk.Button(v, text="Crear Tratamiento", command=agregar_tratamiento).pack(fill="x", pady=5)
    tk.Button(v, text="Listar Catálogo", command=listar_tratamientos).pack(fill="x", pady=5)
    tk.Button(v, text="Editar Tratamiento", command=editar_tratamiento).pack(fill="x", pady=5)
    tk.Button(v, text="Eliminar Tratamiento", command=eliminar_tratamiento).pack(fill="x", pady=5)

def menu_enfermeras():
    v = tk.Toplevel(root)
    v.title("Gestión Enfermeras")
    v.geometry("300x300")
    tk.Button(v, text="Registrar Enfermera", command=agregar_enfermera).pack(fill="x", pady=5)
    tk.Button(v, text="Listar Enfermeras", command=listar_enfermeras).pack(fill="x", pady=5)
    tk.Button(v, text="Editar Enfermera", command=editar_enfermera).pack(fill="x", pady=5)
    tk.Button(v, text="Eliminar Enfermera", command=eliminar_enfermera).pack(fill="x", pady=5)

def menu_proveedores():
    v = tk.Toplevel(root)
    v.title("Gestión Proveedores")
    v.geometry("300x300")
    tk.Button(v, text="Registrar Proveedor", command=agregar_proveedor).pack(fill="x", pady=5)
    tk.Button(v, text="Listar Proveedores", command=listar_proveedores).pack(fill="x", pady=5)
    tk.Button(v, text="Editar Proveedor", command=editar_proveedor).pack(fill="x", pady=5)
    tk.Button(v, text="Eliminar Proveedor", command=eliminar_proveedor).pack(fill="x", pady=5)

# ==========================
# 12. VENTANA PRINCIPAL
# ==========================
root = tk.Tk()
root.title("Sistema Clínica")
root.geometry("400x600")

tk.Label(root, text="CLÍNICA - PANEL DE CONTROL", font=("Arial", 14, "bold")).pack(pady=20)

tk.Label(root, text="--- RECEPCIÓN ---", fg="gray").pack()
tk.Button(root, text="Pacientes", width=30, command=menu_pacientes).pack(pady=3)
tk.Button(root, text="Citas", width=30, command=menu_citas).pack(pady=3)
tk.Button(root, text="Facturación", width=30, command=menu_facturas).pack(pady=3)

tk.Label(root, text="--- MÉDICO / TÉCNICO ---", fg="gray").pack(pady=(15, 0))
tk.Button(root, text="Tratamientos (Catálogo)", width=30, command=menu_tratamientos).pack(pady=3)
tk.Button(root, text="Profesionales", width=30, command=menu_profesionales).pack(pady=3)
tk.Button(root, text="Enfermeras", width=30, command=menu_enfermeras).pack(pady=3)

tk.Label(root, text="--- LOGÍSTICA ---", fg="gray").pack(pady=(15, 0))
tk.Button(root, text="Inventario", width=30, command=menu_inventario).pack(pady=3)
tk.Button(root, text="Proveedores", width=30, command=menu_proveedores).pack(pady=3)

root.mainloop()
